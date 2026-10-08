
import 'package:flutter_todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../models/user.dart';

@lazySingleton
class AuthStateChanges {
  final AuthRepository _repository;

  AuthStateChanges(this._repository);

  Stream<User?> call() => _repository.authStateChanges();
}