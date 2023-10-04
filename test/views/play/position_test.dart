import 'dart:math';

import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final config = BoardConfig.medium();
  final adjacentsOf = config.adjacentsOf;
  final toIndex = config.toIndex;
  final toPos = config.toPos;

  const pos = (4, 2);

  group("adjacents of position", () {
    test("should not contain itself", () {
      expect(adjacentsOf(pos), isNot(contains(pos)));
    });

    test("should contain only positions in distance of 1", () {
      final adjacents = adjacentsOf(pos);
      for (final p in adjacents) {
        final r = (p.$1 - pos.$1).abs();
        final c = (p.$2 - pos.$2).abs();
        expect(max(r, c), 1);
      }
    });

    test("should have valid positions", () {
      expect(adjacentsOf((0, 0)).length, 3);
      expect(adjacentsOf((0, 1)).length, 5);
      expect(adjacentsOf((1, 1)).length, 8);
    });
  });

  group("position-index conversion", () {
    test("should be inverse relation", () {
      expect(toPos(toIndex(pos)), pos);
    });
  });

  group("negating position", () {
    test("should satisfy involution", () {
      expect(-(-pos), pos);
    });

    test("should satisfy identity about position-index conversion", () {
      expect(toPos(toIndex(-pos)), -pos);
    });

    test("should be different from the original", () {
      for (int i = 0; i < config.rowCount; i++) {
        for (int j = 0; j < config.colCount; j++) {
          expect(-(i, j), isNot((i, j)));
        }
      }
    });
  });
}
