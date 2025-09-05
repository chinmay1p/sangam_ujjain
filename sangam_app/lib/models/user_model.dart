class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final int punya;
  final List<String> badges;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    this.punya = 0,
    this.badges = const [],
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'punya': punya,
      'badges': badges,
    };
  }

  // Create User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      punya: json['punya'] ?? 0,
      badges: List<String>.from(json['badges'] ?? []),
    );
  }

  // Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    int? punya,
    List<String>? badges,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      punya: punya ?? this.punya,
      badges: badges ?? this.badges,
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

