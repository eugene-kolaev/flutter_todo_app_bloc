part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent{
  const AuthStarted();
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({
    required this.email,
    required this.password
});
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUpRequested({
    required this.email,
    required this.password,
});
}

class AuthSignOutRequested extends AuthEvent{
  const AuthSignOutRequested();
}