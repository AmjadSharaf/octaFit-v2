import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/app_exception.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/network/api_result.dart';
import 'package:octafit/core/services/logger_service.dart';
import 'package:octafit/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:octafit/features/authentication/data/datasources/auth_remote_data_source.dart';

import 'package:octafit/features/authentication/domain/entities/user_entity.dart';
import 'package:octafit/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final LoggerService _logger;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._logger,
  );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.login(email, password);
      await _localDataSource.cacheUser(user);
      return Right(user.toEntity());
    } on AppException catch (e) {
      _logger.error('Login failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Login unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final user = await _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      await _localDataSource.cacheUser(user);
      return Right(user.toEntity());
    } on AppException catch (e) {
      _logger.error('Register failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Register unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    return register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: password,
    );
  }

  @override
  Future<Either<Failure, void>> forgotPassword({
    required String email,
  }) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on AppException catch (e) {
      _logger.error('Forgot password failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Forgot password unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        email: email,
        token: token,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return const Right(null);
    } on AppException catch (e) {
      _logger.error('Reset password failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Reset password unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({required String token}) async {
    try {
      await _remoteDataSource.verifyEmail(token);
      return const Right(null);
    } on AppException catch (e) {
      _logger.error('Verify email failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Verify email unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> socialLogin({
    required String provider,
    required String token,
  }) async {
    try {
      final user = await _remoteDataSource.socialLogin(provider, token);
      await _localDataSource.cacheUser(user);
      return Right(user.toEntity());
    } on AppException catch (e) {
      _logger.error('Social login failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Social login unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> refreshToken() async {
    try {
      final user = await _remoteDataSource.refreshToken();
      return Right(user.toEntity());
    } on AppException catch (e) {
      _logger.error('Refresh token failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Refresh token unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _localDataSource.clearCache();
      return const Right(null);
    } on AppException catch (e) {
      _logger.error('Logout failed', e);
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      _logger.error('Logout unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}


