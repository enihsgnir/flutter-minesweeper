import 'dart:math';

import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const difficulty = Difficulty.medium;
  final adjacentsOf = difficulty.adjacentsOf;
  final toIndex = difficulty.toIndex;
  final toPos = difficulty.toPos;

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
      for (int i = 0; i < difficulty.rowCount; i++) {
        for (int j = 0; j < difficulty.colCount; j++) {
          expect(-(i, j), isNot((i, j)));
        }
      }
    });

    test("should be bijective", () {
      final range = <(int, int)>{};
      for (int i = 0; i < difficulty.rowCount; i++) {
        for (int j = 0; j < difficulty.colCount; j++) {
          range.add(-(i, j));
        }
      }

      expect(range, hasLength(difficulty.rowCount * difficulty.colCount));
    });

    test("should have exclusive domain and range", () {
      final domain = <(int, int)>[];
      final range = <(int, int)>[];
      for (int i = 0; i < difficulty.rowCount; i++) {
        for (int j = 0; j < difficulty.colCount; j++) {
          domain.add((i, j));
          range.add(-(i, j));
        }
      }

      expect(range, isNot(anyElement(isIn(domain))));
    });
  });
}
