class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String password; // Added password field
  final int punya;
  final List<String> badges;
  final List<String> familyMemberIds;
  final List<String> pendingFamilyRequests;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    this.punya = 0,
    this.badges = const [],
    this.familyMemberIds = const [],
    this.pendingFamilyRequests = const [],
    required this.createdAt,
    required this.lastLoginAt,
    this.isActive = true,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password, // Note: In production, this should be hashed
      'punya': punya,
      'badges': badges,
      'familyMemberIds': familyMemberIds,
      'pendingFamilyRequests': pendingFamilyRequests,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Create User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      password: json['password'] ?? '',
      punya: json['punya'] ?? 0,
      badges: List<String>.from(json['badges'] ?? []),
      familyMemberIds: List<String>.from(json['familyMemberIds'] ?? []),
      pendingFamilyRequests: List<String>.from(json['pendingFamilyRequests'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLoginAt: DateTime.parse(json['lastLoginAt'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? true,
    );
  }

  // Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? password,
    int? punya,
    List<String>? badges,
    List<String>? familyMemberIds,
    List<String>? pendingFamilyRequests,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      punya: punya ?? this.punya,
      badges: badges ?? this.badges,
      familyMemberIds: familyMemberIds ?? this.familyMemberIds,
      pendingFamilyRequests: pendingFamilyRequests ?? this.pendingFamilyRequests,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

class FamilyMember {
  final String id;
  final String name;

  FamilyMember({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

