sealed class AppException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  const AppException(this.message, {this.code, this.stackTrace});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

final class ServerException extends AppException {
  final int? statusCode;
  final dynamic response;

  const ServerException(
    super.message, {
    super.code,
    this.statusCode,
    this.response,
    super.stackTrace,
  });
}

final class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.code,
    super.stackTrace,
  });
}

final class AuthException extends AppException {
  const AuthException(
    super.message, {
    super.code,
    super.stackTrace,
  });
}

final class CacheException extends AppException {
  const CacheException(
    super.message, {
    super.code,
    super.stackTrace,
  });
}

final class ValidationException extends AppException {
  final Map<String, String>? errors;

  const ValidationException(
    super.message, {
    this.errors,
    super.code,
    super.stackTrace,
  });
}

final class NotFoundException extends AppException {
  const NotFoundException(
    super.message, {
    super.code,
    super.stackTrace,
  });
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException(
    super.message, {
    super.code,
    super.stackTrace,
  });
}

final class TimeoutException extends AppException {
  const TimeoutException(
    super.message, {
    super.code,
    super.stackTrace,
  });
}
