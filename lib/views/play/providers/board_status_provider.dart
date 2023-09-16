import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_minesweeper/views/play/providers/history_provider.dart';
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
      ref.invalidate(playTimeNotifierProvider);

      final config = ref.read(boardConfigNotifierProvider);
      for (int i = 0; i < config.rowCount; i++) {
        for (int j = 0; j < config.colCount; j++) {
          ref.invalidate(cellNotifierProvider((i, j)));
        }
      }
    }
  }
}
