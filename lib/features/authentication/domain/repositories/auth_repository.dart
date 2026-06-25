import 'package:octafit/features/authentication/domain/entities/user_entity.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> forgotPassword({required String email});

  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, void>> verifyEmail({required String token});

  Future<Either<Failure, UserEntity>> socialLogin({
    required String provider,
    required String token,
  });

  Future<Either<Failure, UserEntity>> refreshToken();

  Future<Either<Failure, void>> logout();
}


