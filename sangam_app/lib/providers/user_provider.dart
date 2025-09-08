import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';
import '../services/location_service.dart';
import '../services/sms_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  List<User> _familyMembers = [];
  List<User> _pendingFamilyRequests = [];
  bool _isLoading = false;

  User? get user => _user;
  List<User> get familyMembers => _familyMembers;
  List<User> get pendingFamilyRequests => _pendingFamilyRequests;
  bool get isLoading => _isLoading;

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Register a new user
  Future<void> registerUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _user = await FirebaseService.registerUser(
        name: name,
        email: email,
        mobile: mobile,
        password: password,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error registering user: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Login user
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _user = await FirebaseService.loginUser(
        email: email,
        password: password,
      );
      
      // Load family data
      await _loadFamilyData();
      notifyListeners();
    } catch (e) {
      debugPrint('Error logging in user: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Load family data (members and pending requests)
  Future<void> _loadFamilyData() async {
    if (_user == null) return;

    try {
      _familyMembers = await FirebaseService.getFamilyMembers(_user!.id);
      _pendingFamilyRequests = await FirebaseService.getPendingFamilyRequests(_user!.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading family data: $e');
    }
  }

  // Send family request
  Future<void> sendFamilyRequest(String sangamId) async {
    if (_user == null) return;

    try {
      _setLoading(true);
      await FirebaseService.sendFamilyRequest(
        fromUserId: _user!.id,
        toSangamId: sangamId,
      );
    } catch (e) {
      debugPrint('Error sending family request: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Approve family request
  Future<void> approveFamilyRequest(String requesterId) async {
    if (_user == null) return;

    try {
      _setLoading(true);
      await FirebaseService.approveFamilyRequest(
        approverUserId: _user!.id,
        requesterUserId: requesterId,
      );
      
      // Reload family data
      await _loadFamilyData();
    } catch (e) {
      debugPrint('Error approving family request: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Reject family request
  Future<void> rejectFamilyRequest(String requesterId) async {
    if (_user == null) return;

    try {
      _setLoading(true);
      await FirebaseService.rejectFamilyRequest(
        approverUserId: _user!.id,
        requesterUserId: requesterId,
      );
      
      // Reload family data
      await _loadFamilyData();
    } catch (e) {
      debugPrint('Error rejecting family request: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Increment punya score
  Future<void> incrementPunya(int points) async {
    if (_user == null) return;

    try {
      final updatedUser = _user!.copyWith(punya: _user!.punya + points);
      await FirebaseService.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      debugPrint('Error incrementing punya: $e');
    }
  }

  // Add badge
  Future<void> addBadge(String badge) async {
    if (_user == null) return;

    try {
      final updatedBadges = List<String>.from(_user!.badges);
      if (!updatedBadges.contains(badge)) {
        updatedBadges.add(badge);
        final updatedUser = _user!.copyWith(badges: updatedBadges);
        await FirebaseService.updateUser(updatedUser);
        _user = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error adding badge: $e');
    }
  }

  // Send SOS SMS to family members
  Future<void> sendSOSSMS({String? customMessage}) async {
    if (_user == null || _familyMembers.isEmpty) return;

    try {
      _setLoading(true);
      await SMSService.sendSOSSMS(
        user: _user!,
        familyMembers: _familyMembers,
        customMessage: customMessage,
      );
    } catch (e) {
      debugPrint('Error sending SOS SMS: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    try {
      return await LocationService.requestLocationPermission();
    } catch (e) {
      debugPrint('Error requesting location permission: $e');
      return false;
    }
  }

  // Check if location permission is granted
  Future<bool> isLocationPermissionGranted() async {
    try {
      return await LocationService.isLocationPermissionGranted();
    } catch (e) {
      debugPrint('Error checking location permission: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await FirebaseService.logout();
      _user = null;
      _familyMembers.clear();
      _pendingFamilyRequests.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error logging out: $e');
    }
  }

  // Check if user is logged in
  bool get isLoggedIn => _user != null;

  // Get user's SANGAM ID
  String? get sangamId => _user?.id;
}

