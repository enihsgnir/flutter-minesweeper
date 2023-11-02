import 'dart:math';

import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mines_provider.g.dart';

@riverpod
class MinesNotifier extends _$MinesNotifier {
  @override
  List<(int, int)> build() {
    return [];
  }

  void generate((int, int) firstClick) {
    final difficulty = ref.read(playingDifficultyNotifierProvider);

    final mines = <(int, int)>{};
    final offset = _firstClickOffset(firstClick, difficulty);
    mines.addAll(offset);

    final random = Random();
    while (mines.length < difficulty.mineCount + offset.length) {
      final row = random.nextInt(difficulty.rowCount);
      final col = random.nextInt(difficulty.colCount);
      mines.add((row, col));
    }

    mines.removeAll(offset);

    state = mines.toList();

    for (final mine in state) {
      ref.read(cellNotifierProvider(mine).notifier).setMine();
    }
  }

  Set<(int, int)> _firstClickOffset(
    (int, int) firstClick,
    Difficulty difficulty,
  ) {
    return {
      firstClick,
      ...difficulty.adjacentsOf(firstClick),
    };
  }
}
