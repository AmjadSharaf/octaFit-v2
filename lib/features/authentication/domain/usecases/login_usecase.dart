import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/authentication/domain/entities/user_entity.dart';
import 'package:octafit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:octafit/core/utils/either.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return _repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<Either<Failure, void>> call({required String email}) {
    return _repository.forgotPassword(email: email);
  }
}

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) {
    return _repository.resetPassword(
      email: email,
      token: token,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}

class VerifyEmailUseCase {
  final AuthRepository _repository;

  VerifyEmailUseCase(this._repository);

  Future<Either<Failure, void>> call({required String token}) {
    return _repository.verifyEmail(token: token);
  }
}

class SocialLoginUseCase {
  final AuthRepository _repository;

  SocialLoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String provider,
    required String token,
  }) {
    return _repository.socialLogin(provider: provider, token: token);
  }
}

