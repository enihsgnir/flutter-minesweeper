import 'dart:math';

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
    final config = ref.read(boardConfigNotifierProvider);

    final mines = <(int, int)>{};
    final offset = _firstClickOffset(firstClick, config);
    mines.addAll(offset);

    final random = Random();
    while (mines.length < config.mineCount + offset.length) {
      final row = random.nextInt(config.rowCount);
      final col = random.nextInt(config.colCount);
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
    BoardConfig config,
  ) {
    return {
      firstClick,
      ...config.adjacentsOf(firstClick),
    };
  }
}
