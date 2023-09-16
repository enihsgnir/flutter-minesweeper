import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cell.freezed.dart';

const closedPrimaryColor = Color.fromRGBO(179, 214, 101, 1);
const closedSecondaryColor = Color.fromRGBO(172, 208, 94, 1);
const openPrimaryColor = Color.fromRGBO(223, 195, 163, 1);
const openSecondaryColor = Color.fromRGBO(210, 185, 157, 1);

@freezed
class Cell with _$Cell {
  const factory Cell(
    int row,
    int col, {
    @Default(false) bool hasMine,
    @Default(MineCount.zero) MineCount minesAround,
    @Default(CellStatus.closed) CellStatus status,
  }) = _Cell;

  const Cell._();

  // (int, int) get pos => (row, col);

  // bool get isClosed => status == CellStatus.closed;
  // bool get isFlagged => status == CellStatus.flagged;
  // bool get isOpen => status == CellStatus.open;

  Color get color {
    final isPrimary = row.isEven ^ col.isOdd;

    switch (status) {
      case CellStatus.closed:
      case CellStatus.flagged:
        return isPrimary ? closedPrimaryColor : closedSecondaryColor;
      case CellStatus.open:
        return isPrimary ? openPrimaryColor : openSecondaryColor;
    }
  }

  Widget get widget {
    switch (status) {
      case CellStatus.closed:
        return const Text("");
      case CellStatus.flagged:
        return const Icon(Icons.flag);
      case CellStatus.open:
        return hasMine
            ? const Text("💣")
            : Text(
                minesAround.index.toString(),
                style: TextStyle(
                  color: minesAround.color,
                  fontWeight: FontWeight.bold,
                ),
              );
    }
  }
}
