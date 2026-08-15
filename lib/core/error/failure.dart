import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

final class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(
    super.message, {
    super.code,
    this.statusCode,
  });
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

final class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

final class ValidationFailure extends Failure {
  final Map<String, String>? errors;

  const ValidationFailure(
    super.message, {
    this.errors,
    super.code,
  });
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message, {super.code});
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.code});
}
