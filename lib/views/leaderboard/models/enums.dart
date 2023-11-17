enum Difficulty {
  easy(rowCount: 8, colCount: 10, mineCount: 10),
  medium(rowCount: 14, colCount: 18, mineCount: 40),
  hard(rowCount: 20, colCount: 24, mineCount: 99);

  final int rowCount;
  final int colCount;
  final int mineCount;

  const Difficulty({
    required this.rowCount,
    required this.colCount,
    required this.mineCount,
  });

  double get size {
    return switch (this) {
      easy => 50,
      medium => 30,
      hard => 25,
    };
  }

  double get width => size * colCount;
  double get height => size * rowCount;

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
