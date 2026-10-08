part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.isInitialized = false,
    this.isLoading = false,
    this.error,
  });

  final User? user;

  final bool isInitialized;

  final bool isLoading;

  final String? error;

  bool get isAuthenticated => user != null;

  bool get isUnauthencicated => isInitialized && user == null;

  bool get hasError => error != null;

  AuthState copyWith({
    User? user,
    bool? isInitialized,
    bool? isLoading,
    String? error,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [user, isInitialized, isLoading, error];

}