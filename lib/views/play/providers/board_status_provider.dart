import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_status_provider.g.dart';

@riverpod
class BoardStatusNotifier extends _$BoardStatusNotifier {
  @override
  BoardStatus build() {
    return BoardStatus.ready;
  }

  void next() {
    state = state.toggle();
  }

  void reset() {
    if (state == BoardStatus.playing) {
      ref.read(historyNotifierProvider.notifier).writeCurrentBoard();

      ref.invalidateSelf();
      ref.invalidate(minesNotifierProvider);
      ref.invalidate(cellsLeftNotifierProvider);
      ref.invalidate(minesLeftNotifierProvider);
      ref.invalidate(logNotifierProvider);
      ref.read(playTimeNotifierProvider.notifier).reset();

      final difficulty = ref.read(playingDifficultyNotifierProvider);
      for (int i = 0; i < difficulty.rowCount; i++) {
        for (int j = 0; j < difficulty.colCount; j++) {
          ref.invalidate(cellNotifierProvider((i, j)));
        }
      }
    }
  }
}
