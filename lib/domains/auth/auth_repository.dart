import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_minesweeper/domains/user/user.dart';
import 'package:flutter_minesweeper/domains/user/user_repository.dart';

class AuthRepository {
  Future<User> signIn() async {
    final credential = await FirebaseAuth.instance.signInAnonymously();

    final user = credential.user;
    final info = credential.additionalUserInfo;
    if (user == null || info == null) {
      throw Exception("sign-in-error");
    }

    if (info.isNewUser) {
      return UserRepository().create(user.uid);
    }

    final snapshot = await userRef.whereUid(isEqualTo: user.uid).get();
    return snapshot.docs.single.data;
  }
}
