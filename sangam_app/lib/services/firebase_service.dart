import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart' as user_model;

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  static const String _usersCollection = 'users';
  static const String _countersCollection = 'counters';

  // Generate unique SANGAM ID in format sangam_000001
  static Future<String> generateSangamId() async {
    try {
      final counterDoc = _firestore.collection(_countersCollection).doc('user_counter');
      
      return await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(counterDoc);
        
        int currentCount = 1;
        if (snapshot.exists) {
          currentCount = (snapshot.data()?['count'] ?? 0) + 1;
        }
        
        transaction.set(counterDoc, {'count': currentCount});
        
        return 'sangam_${currentCount.toString().padLeft(6, '0')}';
      });
    } catch (e) {
      throw Exception('Failed to generate SANGAM ID: $e');
    }
  }

  // Register new user
  static Future<user_model.User> registerUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      // Generate unique SANGAM ID
      final sangamId = await generateSangamId();
      
      // Create Firebase Auth user
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('Failed to create Firebase user');
      }

      // Create user document
      final user = user_model.User(
        id: sangamId,
        name: name,
        email: email,
        mobile: mobile,
        password: password, // In production, hash this
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      await _firestore
          .collection(_usersCollection)
          .doc(sangamId)
          .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Login user
  static Future<user_model.User> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Authenticate with Firebase Auth
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('Authentication failed');
      }

      // Find user by email in Firestore
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('User not found');
      }

      final userData = querySnapshot.docs.first.data();
      final user = user_model.User.fromJson(userData);

      // Update last login time
      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .update({'lastLoginAt': DateTime.now().toIso8601String()});

      return user.copyWith(lastLoginAt: DateTime.now());
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Get user by SANGAM ID
  static Future<user_model.User?> getUserById(String sangamId) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(sangamId)
          .get();

      if (doc.exists) {
        return user_model.User.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Update user data
  static Future<void> updateUser(user_model.User user) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Send family request
  static Future<void> sendFamilyRequest({
    required String fromUserId,
    required String toSangamId,
  }) async {
    try {
      final toUser = await getUserById(toSangamId);
      if (toUser == null) {
        throw Exception('User with SANGAM ID $toSangamId not found');
      }

      // Add to pending requests of the target user
      final updatedPendingRequests = List<String>.from(toUser.pendingFamilyRequests);
      if (!updatedPendingRequests.contains(fromUserId)) {
        updatedPendingRequests.add(fromUserId);
        
        await _firestore
            .collection(_usersCollection)
            .doc(toSangamId)
            .update({'pendingFamilyRequests': updatedPendingRequests});
      }
    } catch (e) {
      throw Exception('Failed to send family request: $e');
    }
  }

  // Approve family request
  static Future<void> approveFamilyRequest({
    required String approverUserId,
    required String requesterUserId,
  }) async {
    try {
      final approver = await getUserById(approverUserId);
      final requester = await getUserById(requesterUserId);
      
      if (approver == null || requester == null) {
        throw Exception('User not found');
      }

      // Remove from pending requests
      final updatedPendingRequests = List<String>.from(approver.pendingFamilyRequests);
      updatedPendingRequests.remove(requesterUserId);

      // Add to family members for both users
      final approverFamilyMembers = List<String>.from(approver.familyMemberIds);
      final requesterFamilyMembers = List<String>.from(requester.familyMemberIds);
      
      if (!approverFamilyMembers.contains(requesterUserId)) {
        approverFamilyMembers.add(requesterUserId);
      }
      if (!requesterFamilyMembers.contains(approverUserId)) {
        requesterFamilyMembers.add(approverUserId);
      }

      // Update both users in a batch
      final batch = _firestore.batch();
      
      batch.update(
        _firestore.collection(_usersCollection).doc(approverUserId),
        {
          'pendingFamilyRequests': updatedPendingRequests,
          'familyMemberIds': approverFamilyMembers,
        },
      );
      
      batch.update(
        _firestore.collection(_usersCollection).doc(requesterUserId),
        {'familyMemberIds': requesterFamilyMembers},
      );
      
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to approve family request: $e');
    }
  }

  // Reject family request
  static Future<void> rejectFamilyRequest({
    required String approverUserId,
    required String requesterUserId,
  }) async {
    try {
      final approver = await getUserById(approverUserId);
      if (approver == null) {
        throw Exception('User not found');
      }

      final updatedPendingRequests = List<String>.from(approver.pendingFamilyRequests);
      updatedPendingRequests.remove(requesterUserId);

      await _firestore
          .collection(_usersCollection)
          .doc(approverUserId)
          .update({'pendingFamilyRequests': updatedPendingRequests});
    } catch (e) {
      throw Exception('Failed to reject family request: $e');
    }
  }

  // Get family members
  static Future<List<user_model.User>> getFamilyMembers(String userId) async {
    try {
      final user = await getUserById(userId);
      if (user == null) {
        return [];
      }

      if (user.familyMemberIds.isEmpty) {
        return [];
      }

      final familyMembers = <user_model.User>[];
      for (final memberId in user.familyMemberIds) {
        final member = await getUserById(memberId);
        if (member != null) {
          familyMembers.add(member);
        }
      }

      return familyMembers;
    } catch (e) {
      throw Exception('Failed to get family members: $e');
    }
  }

  // Get pending family requests
  static Future<List<user_model.User>> getPendingFamilyRequests(String userId) async {
    try {
      final user = await getUserById(userId);
      if (user == null) {
        return [];
      }

      if (user.pendingFamilyRequests.isEmpty) {
        return [];
      }

      final pendingUsers = <user_model.User>[];
      for (final requesterId in user.pendingFamilyRequests) {
        final requester = await getUserById(requesterId);
        if (requester != null) {
          pendingUsers.add(requester);
        }
      }

      return pendingUsers;
    } catch (e) {
      throw Exception('Failed to get pending family requests: $e');
    }
  }

  // Logout
  static Future<void> logout() async {
    await _auth.signOut();
  }

  // Get current Firebase user
  static firebase_auth.User? getCurrentFirebaseUser() {
    return _auth.currentUser;
  }
}
