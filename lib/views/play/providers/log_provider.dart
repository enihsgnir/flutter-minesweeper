import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_provider.g.dart';

@riverpod
class LogNotifier extends _$LogNotifier {
  @override
  List<(int, int)> build() {
    return [];
  }

  void add((int, int) pos) {
    state = [...state, pos];
  }
}
