import 'dart:math';

import 'package:flutter_minesweeper/domains/user/user.dart';

class UserRepository {
  Future<User> create(String uid) async {
    final user = User(
      id: uid,
      nickname: await _generateNickname(),
      createdAt: DateTime.now(),
    );

    await userRef.doc(uid).set(user);
    return user;
  }

  Future<String> _generateNickname() async {
    const width = 4;
    final max = pow(10, 4).toInt();

    final number = Random().nextInt(max).toString().padLeft(width, "0");
    final nickname = "anonymous$number";

    final snapshot = await userRef.whereNickname(isEqualTo: nickname).get();
    if (snapshot.docs.isEmpty) {
      return nickname;
    }
    return _generateNickname();
  }

  Future<User?> getById(String id) async {
    final snapshot = await userRef.doc(id).get();
    return snapshot.data;
  }
}
