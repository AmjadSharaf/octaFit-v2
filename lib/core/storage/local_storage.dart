import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences for app-level persistence.
class LocalStorage {
  LocalStorage(this._prefs);

  final SharedPreferences _prefs;

  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';
  static const _keyAssessmentComplete = 'assessment_complete';
  static const _keyOnboardingComplete = 'onboarding_complete';

  static Future<LocalStorage> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorage(prefs);
  }

  String? get themeMode => _prefs.getString(_keyThemeMode);
  Future<bool> setThemeMode(String value) =>
      _prefs.setString(_keyThemeMode, value);

  String? get locale => _prefs.getString(_keyLocale);
  Future<bool> setLocale(String value) => _prefs.setString(_keyLocale, value);

  bool get assessmentComplete =>
      _prefs.getBool(_keyAssessmentComplete) ?? false;
  Future<bool> setAssessmentComplete(bool value) =>
      _prefs.setBool(_keyAssessmentComplete, value);

  bool get onboardingComplete =>
      _prefs.getBool(_keyOnboardingComplete) ?? false;
  Future<bool> setOnboardingComplete(bool value) =>
      _prefs.setBool(_keyOnboardingComplete, value);
}
