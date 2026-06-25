import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/authentication/domain/entities/user_entity.dart';
import 'package:octafit/features/authentication/domain/usecases/login_usecase.dart';
import 'package:octafit/features/authentication/domain/usecases/logout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _verifyEmailUseCase = verifyEmailUseCase,
        _logoutUseCase = logoutUseCase,
        super(const AuthState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _loginUseCase(email: email, password: password);
    if (result is Left<Failure, UserEntity>) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, UserEntity>) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result.value,
      ));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _registerUseCase(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (result is Left<Failure, UserEntity>) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, UserEntity>) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result.value,
      ));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _forgotPasswordUseCase(email: email);
    if (result is Left<Failure, void>) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, void>) {
      emit(state.copyWith(status: AuthStatus.passwordResetSent));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _resetPasswordUseCase(
      email: email,
      token: token,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (result is Left<Failure, void>) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, void>) {
      emit(state.copyWith(status: AuthStatus.passwordResetComplete));
    }
  }

  Future<void> verifyEmail({required String token}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _verifyEmailUseCase(token: token);
    if (result is Left<Failure, void>) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, void>) {
      emit(state.copyWith(status: AuthStatus.emailVerified));
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  void resetError() {
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      clearError: true,
    ));
  }

  void setAuthenticated(UserEntity user) {
    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
    ));
  }

  void completeProfileSetup() {
    emit(state.copyWith(profileSetupComplete: true));
  }
}
