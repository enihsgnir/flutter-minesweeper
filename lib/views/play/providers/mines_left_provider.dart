import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mines_left_provider.g.dart';

@riverpod
class MinesLeftNotifier extends _$MinesLeftNotifier {
  @override
  int build() {
    final difficulty = ref.watch(playingDifficultyNotifierProvider);
    return difficulty.mineCount;
  }

  void increase() {
    state++;
  }

  void decrease() {
    state--;
  }
}
