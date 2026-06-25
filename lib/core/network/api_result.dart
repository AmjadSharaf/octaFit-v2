import 'package:dio/dio.dart';
import 'package:octafit/core/errors/app_exception.dart';
import 'package:octafit/core/errors/failure.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

final class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}

final class ApiFailure<T> extends ApiResult<T> {
  final Failure failure;

  const ApiFailure(this.failure);
}

extension ApiResultExtensions<T> on ApiResult<T> {
  T? get dataOrNull => switch (this) {
        ApiSuccess<T>(:final data) => data,
        ApiFailure<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        ApiSuccess<T>() => null,
        ApiFailure<T>(:final failure) => failure,
      };

  T get requireData => switch (this) {
        ApiSuccess<T>(:final data) => data,
        ApiFailure<T>(:final failure) => throw failure,
      };
}

Failure mapExceptionToFailure(AppException exception) {
  return switch (exception) {
    ServerException(:final message, :final statusCode, :final code) =>
      ServerFailure(message, code: code, statusCode: statusCode),
    NetworkException(:final message, :final code) =>
      NetworkFailure(message, code: code),
    AuthException(:final message, :final code) =>
      AuthFailure(message, code: code),
    CacheException(:final message, :final code) =>
      CacheFailure(message, code: code),
    ValidationException(:final message, :final code, :final errors) =>
      ValidationFailure(message, code: code, errors: errors),
    NotFoundException(:final message, :final code) =>
      NotFoundFailure(message, code: code),
    UnauthorizedException(:final message, :final code) =>
      UnauthorizedFailure(message, code: code),
    TimeoutException(:final message, :final code) =>
      NetworkFailure(message, code: code),
  };
}

Failure mapDioExceptionToFailure(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout =>
      NetworkFailure('Connection timed out. Please try again.'),
    DioExceptionType.badResponse => _mapStatusCodeToFailure(error),
    DioExceptionType.cancel => NetworkFailure('Request was cancelled.'),
    DioExceptionType.connectionError =>
      NetworkFailure('No internet connection.'),
    _ => ServerFailure(
        error.message ?? 'An unexpected error occurred.',
        statusCode: error.response?.statusCode,
      ),
  };
}

Failure _mapStatusCodeToFailure(DioException error) {
  final statusCode = error.response?.statusCode;
  final message = error.response?.statusMessage ?? 'An error occurred.';

  return switch (statusCode) {
    400 => ValidationFailure(message),
    401 => UnauthorizedFailure('Session expired. Please login again.'),
    403 => AuthFailure('Access denied.'),
    404 => NotFoundFailure('Resource not found.'),
    422 => ValidationFailure(
        message,
        errors: error.response?.data is Map
            ? (error.response!.data as Map).map(
                (k, v) => MapEntry(k.toString(), v.toString()),
              )
            : null,
      ),
    429 => ServerFailure('Too many requests. Please slow down.'),
    _ when statusCode != null && statusCode >= 500 =>
      ServerFailure('Server error. Please try again later.',
          statusCode: statusCode),
    _ => ServerFailure(message, statusCode: statusCode),
  };
}

