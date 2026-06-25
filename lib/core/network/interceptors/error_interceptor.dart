import 'package:dio/dio.dart';
import 'package:octafit/core/errors/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final exception = _mapToAppException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
        message: exception.message,
      ),
    );
  }

  AppException _mapToAppException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException('Request timed out.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractMessage(error.response?.data);
        switch (statusCode) {
          case 400:
            return ValidationException(message);
          case 401:
            return UnauthorizedException(message);
          case 403:
            return AuthException('Access denied.');
          case 404:
            return NotFoundException(message);
          case 422:
            return ValidationException(message, errors: _extractErrors(error.response?.data));
          case 500:
          case 502:
          case 503:
            return ServerException(message, statusCode: statusCode);
          default:
            return ServerException(message, statusCode: statusCode);
        }
      case DioExceptionType.cancel:
        return const NetworkException('Request cancelled.');
      case DioExceptionType.connectionError:
        return const NetworkException('No internet connection.');
      default:
        return ServerException(error.message ?? 'An unexpected error occurred.');
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map && data.containsKey('message')) {
      return data['message'] as String;
    }
    if (data is Map && data.containsKey('error')) {
      return data['error'] as String;
    }
    return 'An error occurred.';
  }

  Map<String, String>? _extractErrors(dynamic data) {
    if (data is Map && data.containsKey('errors')) {
      final errors = data['errors'];
      if (errors is Map) {
        return errors.map((k, v) => MapEntry(k.toString(), v.toString()));
      }
    }
    return null;
  }
}

