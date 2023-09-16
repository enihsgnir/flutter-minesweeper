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
    mines.add(firstClick);

    final random = Random();
    while (mines.length <= config.mineCount) {
      final row = random.nextInt(config.rowCount);
      final col = random.nextInt(config.colCount);
      mines.add((row, col));
    }

    mines.remove(firstClick);

    state = mines.toList();

    for (final mine in state) {
      ref.read(cellNotifierProvider(mine).notifier).setMine();
    }
  }
}
