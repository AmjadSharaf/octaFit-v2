import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/storage/preferences_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final PreferencesService _preferences;
  static const _themeKey = 'octafit_theme_mode';

  SettingsCubit({required PreferencesService preferences})
      : _preferences = preferences,
        super(const SettingsState()) {
    _load();
  }

  Future<void> _load() async {
    final stored = _preferences.getString(_themeKey);
    if (stored == 'light') {
      emit(state.copyWith(themeMode: ThemeMode.light));
    } else if (stored == 'dark') {
      emit(state.copyWith(themeMode: ThemeMode.dark));
    }
  }

  Future<void> toggleTheme() async {
    final newMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newMode));
    await _preferences.setString(
      _themeKey,
      newMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _preferences.setString(
      _themeKey,
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  void toggleNotifications() {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  void changeLocale(String locale) {
    emit(state.copyWith(locale: locale));
  }
}
