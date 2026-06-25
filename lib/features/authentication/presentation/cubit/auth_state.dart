part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  emailVerified,
  passwordResetSent,
  passwordResetComplete,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final bool profileSetupComplete;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.profileSetupComplete = false,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    bool? profileSetupComplete,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      profileSetupComplete: profileSetupComplete ?? this.profileSetupComplete,
    );
  }

  @override
  List<Object?> get props =>
      [status, user, errorMessage, profileSetupComplete];
}
