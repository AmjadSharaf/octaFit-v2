abstract final class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static const String contentType = 'application/json';
  static const String authHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
  static const String refreshTokenHeader = 'X-Refresh-Token';
  static const String apiKeyHeader = 'X-API-Key';
  static const String localeHeader = 'X-Locale';

  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
