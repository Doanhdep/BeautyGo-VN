import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/models/auth_user_model.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  /// LOGIN
  Future<AuthUserModel?> login({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) return null;

    final profileData =
        await supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle();

    if (profileData == null) {
      final fallbackUser = AuthUserModel(
        id: user.id,
        email: user.email ?? email,
        username:
            (user.email ?? email).split('@').first.isNotEmpty
                ? (user.email ?? email).split('@').first
                : 'beauty_user',
        fullName:
            (user.userMetadata?['full_name'] as String?)?.trim().isNotEmpty ==
                    true
                ? (user.userMetadata?['full_name'] as String)
                : ((user.email ?? email).split('@').first),
        role: 'enthusiast',
        avatarUrl: null,
        bio: null,
        phone: null,
        isActive: true,
        createdAt: DateTime.now(),
      );

      await supabase.from('profiles').insert(fallbackUser.toJson());
      return fallbackUser;
    }

    return AuthUserModel.fromJson(profileData);
  }

  /// REGISTER
  Future<AuthUserModel?> register({
    required String email,
    required String password,
    required String username,
    required String fullName,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) return null;

    final authUser = AuthUserModel(
      id: user.id,
      email: email,
      username: username,
      fullName: fullName,
      role: 'enthusiast',
      avatarUrl: null,
      bio: null,
      phone: null,
      isActive: true,
      createdAt: DateTime.now(),
    );

    await supabase.from('profiles').insert(authUser.toJson());

    return authUser;
  }

  /// CURRENT USER
  Future<AuthUserModel?> getCurrentUser() async {
    final user = supabase.auth.currentUser;

    if (user == null) return null;

    final profileData =
        await supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle();

    if (profileData == null) return null;

    return AuthUserModel.fromJson(profileData);
  }

  /// LOGOUT
  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
