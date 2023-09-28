import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'win_status_provider.g.dart';

@riverpod
class WinStatusNotifier extends _$WinStatusNotifier {
  @override
  WinStatus? build() {
    final mines = ref.watch(minesNotifierProvider);
    if (mines.any(_isOpen)) {
      return WinStatus.over;
    }

    final config = ref.watch(boardConfigNotifierProvider);
    final cellsLeft = ref.watch(cellsLeftNotifierProvider);
    final minesLeft = ref.watch(minesLeftNotifierProvider);
    if (cellsLeft > config.difficulty.mineCount || minesLeft > 0) {
      return null;
    }

    if (mines.every(_isFlagged)) {
      return WinStatus.win;
    }

    return null;
  }

  Cell _cellAt((int, int) pos) => ref.watch(cellNotifierProvider(pos));

  bool _isOpen((int, int) pos) => _cellAt(pos).status == CellStatus.open;
  bool _isFlagged((int, int) pos) => _cellAt(pos).status == CellStatus.flagged;
}
