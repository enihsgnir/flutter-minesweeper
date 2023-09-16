extension CellExtension on (int, int) {
  Iterable<(int, int)> adjacent(int rowCount, int colCount) sync* {
    final i = $1;
    final j = $2;

    for (final pos in [
      (i, j + 1),
      (i, j - 1),
      (i + 1, j),
      (i - 1, j),
      (i + 1, j + 1),
      (i + 1, j - 1),
      (i - 1, j + 1),
      (i - 1, j - 1),
    ]) {
      final (row, col) = pos;
      if (row < 0 || row >= rowCount || col < 0 || col >= colCount) {
        continue;
      }
      yield pos;
    }

    // for (final di in [-1, 0, 1]) {
    //   for (final dj in [-1, 0, 1]) {
    //     if (di == 0 && dj == 0) {
    //       continue;
    //     }

    //     final row = $1 + di;
    //     final col = $2 + dj;
    //     if (row < 0 || row >= rowCount || col < 0 || col >= colCount) {
    //       continue;
    //     }

    //     yield (row, col);
    //   }
    // }
  }

  // (int, int) operator *(int n) => ($1 * n, $2 * n);
  // (int, int) operator -() => this * -1;

  (int, int) operator -() => (-$1, -$2);
}
