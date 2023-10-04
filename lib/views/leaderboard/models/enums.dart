import 'package:flutter_minesweeper/views/play/play_view.dart';

enum Difficulty {
  easy,
  medium,
  hard;

  int get row {
    switch (this) {
      case Difficulty.easy:
        return BoardConfig.easy().rowCount;
      case Difficulty.medium:
        return BoardConfig.medium().rowCount;
      case Difficulty.hard:
        return BoardConfig.hard().rowCount;
    }
  }

  int get col {
    switch (this) {
      case Difficulty.easy:
        return BoardConfig.easy().colCount;
      case Difficulty.medium:
        return BoardConfig.medium().colCount;
      case Difficulty.hard:
        return BoardConfig.hard().colCount;
    }
  }
}
