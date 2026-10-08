import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';

import 'package:flutter_todo_app/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:flutter_todo_app/features/auth/data/dto/user_model.dart';
import 'package:flutter_todo_app/features/auth/domain/models/user.dart';
import 'package:flutter_todo_app/features/auth/domain/repository/auth_repository.dart';

import '../../domain/exceptions/auth_exception.dart';



@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final fbUser = await _dataSource.signIn(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(fbUser).toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final fbUser = await _dataSource.signUp(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(fbUser).toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  User? get currentUser {
    final fbUser = _dataSource.currentUser;
    if (fbUser == null) return null;
    return UserModel.fromFirebase(fbUser).toEntity();
  }

  @override
  Stream<User?> authStateChanges() {
    return _dataSource.authStateChanges().map((fbUser) {
      if (fbUser == null) return null;
      return UserModel.fromFirebase(fbUser).toEntity();
    });
  }

  AuthException _mapFirebaseException(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
        return const InvalidCredentialsException();

      case 'user-not-found':
        return const UserNotFoundException();

      case 'email-already-in-use':
        return const EmailAlreadyInUseException();

      case 'weak-password':
        return const WeakPasswordException();

      case 'invalid-email':
        return const InvalidEmailException();

      case 'too-many-requests':
        return const TooManyRequestsException();

      case 'operation-not-allowed':
      case 'cancelled-popup-request':
        return const OperationCancelledException();

      default:
        return UnknownAuthException(e.message ?? e.code);
    }
  }

}
