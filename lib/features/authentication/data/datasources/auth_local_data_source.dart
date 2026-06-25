import 'package:octafit/core/storage/preferences_service.dart';
import 'package:octafit/core/storage/secure_storage_service.dart';
import 'package:octafit/features/authentication/data/models/user_model.dart';
import 'dart:convert';

class AuthLocalDataSource {
  final SecureStorageService _secureStorage;
  final PreferencesService _preferences;

  AuthLocalDataSource(this._secureStorage, this._preferences);

  static const _userKey = 'cached_user';
  static const _onboardingKey = 'onboarding_complete';
  static const _assessmentKey = 'assessment_complete';

  Future<void> cacheUser(UserModel user) async {
    await _preferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  UserModel? getCachedUser() {
    final json = _preferences.getString(_userKey);
    if (json == null) return null;
    return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> clearCache() async {
    await _preferences.remove(_userKey);
    await _secureStorage.clearAll();
  }

  bool get isOnboardingComplete =>
      _preferences.getBool(_onboardingKey) ?? false;

  Future<void> setOnboardingComplete(bool value) async {
    await _preferences.setBool(_onboardingKey, value);
  }

  bool get isAssessmentComplete =>
      _preferences.getBool(_assessmentKey) ?? false;

  Future<void> setAssessmentComplete(bool value) async {
    await _preferences.setBool(_assessmentKey, value);
  }

  Future<bool> hasToken() => _secureStorage.hasToken();
}

