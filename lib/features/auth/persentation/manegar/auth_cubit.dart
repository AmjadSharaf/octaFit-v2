import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octafitv2/features/auth/domain/Repositories/auth_repository.dart';
import 'package:octafitv2/features/auth/persentation/manegar/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // افترض أن لديك repository للمصادقة
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    // التحقق من حالة تسجيل الدخول عند الإنشاء
    checkAuthStatus();
  }

  /// التحقق مما إذا كان المستخدم مسجل دخوله مسبقاً
  Future<void> checkAuthStatus() async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.getCurrentUser();
      
      if (user != null) {
        emit(AuthAuthenticated(
          userId: user.id,
          email: user.email,
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError('فشل في التحقق من حالة المصادقة'));
    }
  }

  /// تسجيل الدخول
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.login(email, password);
      
      emit(AuthAuthenticated(
        userId: user.id,
        email: user.email,
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
      // إعادة الحالة السابقة بعد فترة قصيرة
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthUnauthenticated());
    }
  }

  /// إنشاء حساب جديد
  Future<void> register(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.register(email, password, name);
      
      emit(AuthAuthenticated(
        userId: user.id,
        email: user.email,
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// تسجيل الخروج
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