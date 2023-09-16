import 'dart:math';

import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_config_provider.g.dart';

@riverpod
class BoardConfigNotifier extends _$BoardConfigNotifier {
  @override
  BoardConfig build() {
    return BoardConfig.medium();
  }

  void setToEasy() {
    state = BoardConfig.easy();
  }

  void setToMedium() {
    state = BoardConfig.medium();
  }

  void setToHard() {
    state = BoardConfig.medium();
  }

  void setToCustom(int rowCount, int colCount) {
    state = BoardConfig(
      rowCount: rowCount,
      colCount: colCount,
      mineCount: rowCount * colCount ~/ 5,
      size: 500 / max(rowCount, colCount),
    );
  }
}
