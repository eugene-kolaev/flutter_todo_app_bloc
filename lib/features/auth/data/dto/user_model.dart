import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../domain/models/user.dart';


class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;


  const UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl
});

  factory UserModel.fromFirebase(fb.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  User toEntity() {
   return User(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

}