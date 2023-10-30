import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_minesweeper/domains/user/user.dart';
import 'package:flutter_minesweeper/domains/user/user_repository.dart';

class AuthRepository {
  Future<User> signIn() async {
    final credential = await FirebaseAuth.instance.signInAnonymously();

    final authUser = credential.user;
    final info = credential.additionalUserInfo;
    if (authUser == null || info == null) {
      throw Exception("sign-in-error");
    }

    if (info.isNewUser) {
      return UserRepository().create(authUser.uid);
    }

    final user = await UserRepository().getById(authUser.uid);
    if (user == null) {
      throw Exception("not-created");
    }

    return user;
  }
}
