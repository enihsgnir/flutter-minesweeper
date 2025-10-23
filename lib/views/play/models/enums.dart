import 'dart:math';

import 'package:flutter/material.dart';

enum BoardStatus {
  ready,
  playing,
  done,
}

enum CellStatus {
  closed,
  flagged,
  open;

  CellStatus onTap() => switch (this) {
        closed => open,
        flagged || open => this,
      };

  CellStatus onSecondaryTap() => switch (this) {
        closed => flagged,
        flagged => closed,
        open => this,
      };
}

enum WinStatus {
  over,
  win,
}

enum MineCount {
  zero(color: Colors.transparent),
  one(color: Color.fromRGBO(56, 116, 203, 1)),
  two(color: Color.fromRGBO(80, 140, 70, 1)),
  three(color: Color.fromRGBO(194, 63, 56, 1)),
  four(color: Color.fromRGBO(113, 39, 156, 1)),
  five(color: Color.fromRGBO(240, 149, 54, 1)),
  six(color: Color.fromRGBO(66, 149, 165, 1)),
  seven,
  eight;

  final Color color;

  const MineCount({
    this.color = Colors.black,
  });

  MineCount operator +(int n) {
    const values = MineCount.values;
    final lastIndex = values.length - 1;
    return values[min(lastIndex, index + n)];
  }
}
