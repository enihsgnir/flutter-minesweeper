import 'dart:collection';

import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cell_provider.g.dart';

@riverpod
class CellNotifier extends _$CellNotifier {
  @override
  Cell build((int, int) pos) {
    return Cell(pos.$1, pos.$2);
  }

  void increaseMineCount() {
    MineCount minesAround = state.minesAround;
    state = state.copyWith(minesAround: ++minesAround);
  }

  void setMine() {
    state = state.copyWith(hasMine: true);

    final difficulty = ref.watch(playingDifficultyNotifierProvider);
    final pos = (state.row, state.col);
    difficulty.adjacentsOf(pos).forEach((element) {
      ref.read(cellNotifierProvider(element).notifier).increaseMineCount();
    });
  }

  void setOpen() {
    state = state.copyWith(status: CellStatus.open);
  }

  Cell _cellAt((int, int) other) {
    if (other == pos) {
      return state;
    }
    return ref.read(cellNotifierProvider(other));
  }

  void open() {
    final q = Queue<(int, int)>();
    q.add(pos);
    while (q.isNotEmpty) {
      final p = q.removeFirst();
      final cell = _cellAt(p);
      if (cell.status != CellStatus.closed) {
        continue;
      }

      ref.read(cellNotifierProvider(p).notifier).setOpen();
      ref.read(cellsLeftNotifierProvider.notifier).decrease();

      if (cell.minesAround == MineCount.zero) {
        final difficulty = ref.read(playingDifficultyNotifierProvider);
        difficulty
            .adjacentsOf(p)
            .where((element) => !_cellAt(element).hasMine)
            .forEach(q.add);
      }
    }
  }

  bool _isReadyToOpenAdjacent() {
    final difficulty = ref.read(playingDifficultyNotifierProvider);
    final adjacents = difficulty.adjacentsOf(pos);
    final flaggedCount = adjacents
        .where((element) => _cellAt(element).status == CellStatus.flagged)
        .length;
    return flaggedCount == state.minesAround.index;
  }

  void openAdjacent() {
    if (!_isReadyToOpenAdjacent()) {
      return;
    }

    final difficulty = ref.read(playingDifficultyNotifierProvider);
    final adjacents = difficulty.adjacentsOf(pos);
    for (final p in adjacents) {
      final cell = _cellAt(p);
      if (cell.status == CellStatus.closed) {
        ref.read(cellNotifierProvider(p).notifier).setOpen();
      }
    }
  }

  void toggle() {
    switch (state.status) {
      case CellStatus.closed:
        state = state.copyWith(status: CellStatus.flagged);
        ref.read(minesLeftNotifierProvider.notifier).decrease();
      case CellStatus.flagged:
        state = state.copyWith(status: CellStatus.closed);
        ref.read(minesLeftNotifierProvider.notifier).increase();
      case CellStatus.open:
        return;
    }
  }
}
