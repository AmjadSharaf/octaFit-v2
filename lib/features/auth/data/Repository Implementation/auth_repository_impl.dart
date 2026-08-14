import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:octafitv2/features/auth/data/Model/data/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/Repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _prefs;
  final String _baseUrl = 'http://127.0.0.1:8000/api'; // غيّر الرابط

  AuthRepositoryImpl(this._prefs);

  @override
  Future<User?> getCurrentUser() async {
    final token = _prefs.getString('token');
    if (token == null) return null;

    return User(
      id: int.tryParse(_prefs.getString('user_id') ?? '') ?? 0,
      name: _prefs.getString('user_name') ?? '',
      email: _prefs.getString('user_email') ?? '',
      token: token,
      type: _prefs.getString('user_type'),
    );
  }

  @override
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data, token: data['token']);
      await _saveUserData(user);
      return user;
    } else {
      throw Exception('فشل تسجيل الدخول: ${response.body}');
    }
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data, token: data['token']);
      await _saveUserData(user);
      return user;
    } else {
      throw Exception('فشل إنشاء الحساب: ${response.body}');
    }
  }

  @override
  Future<void> logout() async {
    await _prefs.clear();
  }

  Future<void> _saveUserData(User user) async {
    await _prefs.setString('token', user.token ?? '');
    await _prefs.setString('user_id', user.id.toString());
    await _prefs.setString('user_name', user.name);
    await _prefs.setString('user_email', user.email);
    if (user.type != null) {
      await _prefs.setString('user_type', user.type!);
    }
  }
}
