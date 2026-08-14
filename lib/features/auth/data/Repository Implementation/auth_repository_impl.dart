

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/Repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._prefs);

  @override
  Future<User?> getCurrentUser() async {
    final token = _prefs.getString('token');
    if (token == null) return null;

    return User(
      id: _prefs.getString('user_id') ?? '',
      email: _prefs.getString('user_email') ?? '',
    );
  }

  @override
  Future<User> login(String email, String password) async {
    await _prefs.setString('token', 'fake_token_123');
    await _prefs.setString('user_email', email);
    await _prefs.setString('user_id', '1');

    return User(id: '1', email: email);
  }

  @override
  Future<User> register(String email, String password, String name) async {
    await _prefs.setString('token', 'fake_token_456');
    return User(id: '2', email: email, name: name);
  }

  @override
  Future<void> logout() async {
    await _prefs.remove('token');
    await _prefs.remove('user_email');
    await _prefs.remove('user_id');
  }
}