import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octafitv2/features/auth/domain/Repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(
          AuthAuthenticated(
            user: user,
           
          ),
        );
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError('فشل في التحقق من حالة المصادقة'));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.login(email, password);
      emit(
        AuthAuthenticated(
          user: user,
        
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      emit(
        AuthAuthenticated(
          user: user,
       
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await _authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('فشل في تسجيل الخروج'));
    }
  }
}
