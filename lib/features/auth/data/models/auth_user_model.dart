class AuthUserModel {
  final String id;
  final String email;
  final String username;
  final String fullName;
  final String role;
  final String? avatarUrl;
  final String? bio;
  final String? phone;
  final bool isActive;
  final DateTime? createdAt;

  const AuthUserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    required this.role,
    this.avatarUrl,
    this.bio,
    this.phone,
    required this.isActive,
    this.createdAt,
  });

  /// JSON -> Model
  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      role: json['role'] ?? 'enthusiast',
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      phone: json['phone'],
      isActive: json['is_active'] ?? true,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
    );
  }

  /// Model -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'full_name': fullName,
      'role': role,
      'avatar_url': avatarUrl,
      'bio': bio,
      'phone': phone,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// copyWith
  AuthUserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? fullName,
    String? role,
    String? avatarUrl,
    String? bio,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return AuthUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return '''
AuthUserModel(
  id: $id,
  email: $email,
  username: $username,
  fullName: $fullName,
  role: $role
)
''';
  }
}
