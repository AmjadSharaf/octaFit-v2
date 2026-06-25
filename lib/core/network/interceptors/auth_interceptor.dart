import 'package:dio/dio.dart';
import 'package:octafit/core/storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;
  bool _isRefreshing = false;

  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshToken = await _secureStorage.getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          final dio = err.requestOptions.extra['dio'] as Dio?;
          if (dio != null) {
            final response = await dio.post(
              '/auth/refresh',
              data: {'refresh_token': refreshToken},
              options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
            );
            final newToken = response.data['access_token'] as String?;
            if (newToken != null) {
              await _secureStorage.saveAccessToken(newToken);
              err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final retryResponse = await dio.fetch(err.requestOptions);
              _isRefreshing = false;
              handler.resolve(retryResponse);
              return;
            }
          }
        }
      } catch (_) {
      }
      _isRefreshing = false;
      await _secureStorage.clearTokens();
    }
    handler.next(err);
  }
}
