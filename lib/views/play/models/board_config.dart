import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_config.freezed.dart';

@freezed
class BoardConfig with _$BoardConfig {
  const factory BoardConfig({
    required int rowCount,
    required int colCount,
    required int mineCount,
    required double size,
  }) = _BoardConfig;

  const BoardConfig._();

  factory BoardConfig.easy() {
    return const BoardConfig(
      rowCount: 8,
      colCount: 10,
      mineCount: 10,
      size: 50,
    );
  }

  factory BoardConfig.medium() {
    return const BoardConfig(
      rowCount: 14,
      colCount: 18,
      mineCount: 40,
      size: 30,
    );
  }

  factory BoardConfig.hard() {
    return const BoardConfig(
      rowCount: 20,
      colCount: 24,
      mineCount: 99,
      size: 25,
    );
  }

  Iterable<(int, int)> adjacentsOf((int, int) pos) sync* {
    for (final dr in [-1, 0, 1]) {
      for (final dc in [-1, 0, 1]) {
        if (dr == 0 && dc == 0) {
          continue;
        }

        final row = pos.$1 + dr;
        final col = pos.$2 + dc;
        if (row < 0 || row >= rowCount || col < 0 || col >= colCount) {
          continue;
        }

        yield (row, col);
      }
    }
  }

  int toIndex((int, int) pos) => pos.$1 * colCount + pos.$2;

  (int, int) toPos(int index) => (index ~/ colCount, index.remainder(colCount));
}
