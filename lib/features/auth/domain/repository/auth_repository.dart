import 'package:flutter_todo_app/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  Future<User> signIn({ required String email, required String password});

  Future<User> signUp({required String email, required String password});

  Future<void> signOut();

  User? get currentUser;

  Stream<User?> authStateChanges();
}
