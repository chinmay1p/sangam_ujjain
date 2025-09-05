import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  List<FamilyMember> _familyMembers = [];

  User? get user => _user;
  List<FamilyMember> get familyMembers => _familyMembers;

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString('userData');
      
      if (userDataString != null) {
        final userData = jsonDecode(userDataString);
        _user = User.fromJson(userData);
        notifyListeners();
      }

      // Load family members
      if (_user != null) {
        await _loadFamilyMembers();
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  // Save user data to SharedPreferences
  Future<void> saveUserData(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = jsonEncode(user.toJson());
      await prefs.setString('userData', userDataString);
      _user = user;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }

  // Register a new user
  Future<void> registerUser(String name, String email, String mobile, String id) async {
    final newUser = User(
      id: id,
      name: name,
      email: email,
      mobile: mobile,
    );
    await saveUserData(newUser);
  }

  // Add family member
  Future<void> addFamilyMember(String name, String id) async {
    if (_user == null) return;

    final newMember = FamilyMember(id: id, name: name);
    _familyMembers.add(newMember);
    await _saveFamilyMembers();
    notifyListeners();
  }

  // Remove family member
  Future<void> removeFamilyMember(String id) async {
    if (_user == null) return;

    _familyMembers.removeWhere((member) => member.id == id);
    await _saveFamilyMembers();
    notifyListeners();
  }

  // Increment punya score
  Future<void> incrementPunya(int points) async {
    if (_user == null) return;

    final updatedUser = _user!.copyWith(punya: _user!.punya + points);
    await saveUserData(updatedUser);
  }

  // Add badge
  Future<void> addBadge(String badge) async {
    if (_user == null) return;

    final updatedBadges = List<String>.from(_user!.badges);
    if (!updatedBadges.contains(badge)) {
      updatedBadges.add(badge);
      final updatedUser = _user!.copyWith(badges: updatedBadges);
      await saveUserData(updatedUser);
    }
  }

  // Load family members from SharedPreferences
  Future<void> _loadFamilyMembers() async {
    if (_user == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final familyDataString = prefs.getString('family_${_user!.id}');
      
      if (familyDataString != null) {
        final familyData = jsonDecode(familyDataString) as List;
        _familyMembers = familyData
            .map((member) => FamilyMember.fromJson(member))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading family members: $e');
    }
  }

  // Save family members to SharedPreferences
  Future<void> _saveFamilyMembers() async {
    if (_user == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final familyData = _familyMembers.map((member) => member.toJson()).toList();
      final familyDataString = jsonEncode(familyData);
      await prefs.setString('family_${_user!.id}', familyDataString);
    } catch (e) {
      debugPrint('Error saving family members: $e');
    }
  }

  // Clear user data (for logout)
  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');
      if (_user != null) {
        await prefs.remove('family_${_user!.id}');
      }
      _user = null;
      _familyMembers.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing user data: $e');
    }
  }
}

