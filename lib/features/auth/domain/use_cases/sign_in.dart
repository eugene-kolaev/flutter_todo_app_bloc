import 'package:flutter_todo_app/features/auth/domain/exceptions/auth_exception.dart';
import 'package:flutter_todo_app/features/auth/domain/models/user.dart';
import 'package:flutter_todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignIn {
  final AuthRepository _repository;

  SignIn(this._repository);

  Future<User> call({required String email, required String password}) {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty || !trimmedEmail.contains('@')) {
      throw const InvalidEmailException();
    }
    if (password.length < 6) {
      throw const WeakPasswordException();
    }

    return _repository.signIn(email: trimmedEmail, password: password);
  }
}
