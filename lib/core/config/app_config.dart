import 'package:logger/logger.dart';

abstract final class AppConfig {
  static bool get isProduction => const bool.fromEnvironment('PRODUCTION');
  static bool get isStaging => const bool.fromEnvironment('STAGING');
  static bool get isDevelopment => !isProduction && !isStaging;

  static String get environment {
    if (isProduction) return 'production';
    if (isStaging) return 'staging';
    return 'development';
  }

  static Level get logLevel {
    if (isProduction) return Level.error;
    if (isStaging) return Level.warning;
    return Level.debug;
  }

  static bool get enableDebugLogging => !isProduction;
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashReporting => isProduction;

  static String get openAiApiKey => const String.fromEnvironment('OPENAI_API_KEY');
  static String get claudeApiKey => const String.fromEnvironment('CLAUDE_API_KEY');
  static String get geminiApiKey => const String.fromEnvironment('GEMINI_API_KEY');
}

