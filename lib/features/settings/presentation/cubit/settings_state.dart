part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final String locale;

  const SettingsState({
    this.themeMode = ThemeMode.dark,
    this.notificationsEnabled = true,
    this.locale = 'en',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    String? locale,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, notificationsEnabled, locale];
}
