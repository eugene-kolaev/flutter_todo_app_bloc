
import 'package:flutter_todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOut {
  final AuthRepository _repository;

  SignOut(this._repository);

  Future<void> call() => _repository.signOut();
}