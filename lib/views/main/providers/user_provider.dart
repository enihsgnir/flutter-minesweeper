import 'package:flutter_minesweeper/domains/user/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  User build() {
    throw UnimplementedError();
  }

  @override
  set state(User user);
}

class UserOverrideNotifier extends UserNotifier {
  final User _user;

  UserOverrideNotifier(this._user);

  @override
  User build() {
    return _user;
  }
}
