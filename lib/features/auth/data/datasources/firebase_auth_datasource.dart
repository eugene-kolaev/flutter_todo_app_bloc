import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseAuthDatasource {
  final fb.FirebaseAuth _auth;

  FirebaseAuthDatasource(this._auth);

  Future<fb.User> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw fb.FirebaseAuthException(
        code: 'user-not-found',
        message: 'signIn вернул null user',
      );
    }
    return user;
  }

  Future<fb.User> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw fb.FirebaseAuthException(
        code: 'unknown',
        message: 'signUp вернул null user',
      );
    }
    return user;
  }

  Future<void> signOut() => _auth.signOut();

  fb.User? get currentUser => _auth.currentUser;

  Stream<fb.User?> authStateChanges() => _auth.authStateChanges();
}
