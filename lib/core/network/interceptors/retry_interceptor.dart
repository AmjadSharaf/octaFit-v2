import 'package:dio/dio.dart';
import 'package:octafit/core/constants/api_constants.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({this.maxRetries = ApiConstants.maxRetries});

  final int maxRetries;
  int _retryCount = 0;

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldRetry(err) && _retryCount < maxRetries) {
      _retryCount++;
      await Future.delayed(ApiConstants.retryDelay);
      try {
        final dio = err.requestOptions.extra['dio'] as Dio?;
        final response = await (dio ?? Dio()).fetch(err.requestOptions);
        handler.resolve(response);
        _retryCount = 0;
      } catch (e) {
        handler.next(err);
      }
    } else {
      _retryCount = 0;
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError =>
        true,
      DioExceptionType.badResponse =>
        error.response?.statusCode == 429 ||
        (error.response?.statusCode ?? 0) >= 500,
      _ => false,
    };
  }
}
