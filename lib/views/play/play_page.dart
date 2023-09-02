import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:go_router/go_router.dart';

const appBarColor = Color.fromRGBO(84, 116, 54, 1);
const closedPrimaryColor = Color.fromRGBO(179, 214, 101, 1);
const closedSecondaryColor = Color.fromRGBO(172, 208, 94, 1);
const openPrimaryColor = Color.fromRGBO(223, 195, 163, 1);
const openSecondaryColor = Color.fromRGBO(210, 185, 157, 1);

final history = ListQueue<Game>(5);

class Board {
  final int rowCount;
  final int columnCount;
  late final List<List<Cell>> cells;
  final List<(int, int)> mines;
  late int cellsLeft;
  late int minesLeft;
  late final List<(int, int)> log;

  Board({
    required this.rowCount,
    required this.columnCount,
    required this.mines,
  }) {
    cells = _generateCells(rowCount, columnCount);
    cellsLeft = rowCount * columnCount;
    minesLeft = mineCount;
    log = [];
  }

  int get mineCount => mines.length;

  Cell cellAt((int, int) position) => cells[position.$1][position.$2];

  static List<List<Cell>> _generateCells(int rowCount, int columnCount) {
    return List.generate(
      rowCount,
      (i) => List.generate(
        columnCount,
        (j) => Cell(row: i, col: j),
      ),
    );
  }

  factory Board.empty(int rowCount, int columnCount) {
    return Board(
      rowCount: rowCount,
      columnCount: columnCount,
      mines: [],
    );
  }

  static List<(int, int)> _generateMines({
    required int rowCount,
    required int columnCount,
    required int mineCount,
    required (int, int) firstClick,
  }) {
    if (mineCount / (rowCount * columnCount) > 0.25) {
      throw Exception("too many mines");
    }

    final mines = <(int, int)>{};
    mines.add(firstClick);

    final random = Random();
    while (mines.length <= mineCount) {
      final row = random.nextInt(rowCount);
      final col = random.nextInt(columnCount);
      mines.add((row, col));
    }

    mines.remove(firstClick);
    return mines.toList();
  }

  factory Board.create({
    required int rowCount,
    required int columnCount,
    required int mineCount,
    required (int, int) firstClick,
  }) {
    return Board(
      rowCount: rowCount,
      columnCount: columnCount,
      mines: _generateMines(
        rowCount: rowCount,
        columnCount: columnCount,
        mineCount: mineCount,
        firstClick: firstClick,
      ),
    );
  }

  bool get hasWon {
    if (cellsLeft > mineCount || minesLeft > 0) {
      return false;
    }
    return mines.every((element) => cellAt(element).hasMine);
  }

  void openCell((int, int) position) {
    final q = Queue<(int, int)>();
    q.add(position);
    while (q.isNotEmpty) {
      final p = q.removeFirst();
      final cell = cellAt(p);
      if (cell.status != CellStatus.closed) {
        continue;
      }

      cell.status = CellStatus.open;
      cellsLeft--;

      if (cell.minesAround.isZero) {
        p
            .around(rowCount, columnCount)
            .where(
              (element) =>
                  !cellAt(element).hasMine &&
                  cellAt(element).status != CellStatus.open,
            )
            .forEach(q.add);
      }
    }

    log.add(position);
  }

  void toggleFlag((int, int) position) {
    final cell = cellAt(position);
    switch (cell.status) {
      case CellStatus.flagged:
        cell.status = CellStatus.closed;
        minesLeft++;
      case CellStatus.closed:
        cell.status = CellStatus.flagged;
        minesLeft--;
      case CellStatus.open:
        return;
    }

    log.add(-position);
  }

  Game toGame() {
    return Game(
      id: "",
      userId: "",
      row: rowCount,
      col: columnCount,
      mineIndice: mines.map((e) => e.$1 * columnCount + e.$2).toList(),
      logIndice: log.map((e) => e.$1 * columnCount + e.$2).toList(),
      createdAt: DateTime.now(),
    );
  }
}

enum MineCount {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight;

  MineCount operator +(int n) {
    const max = 8;
    return MineCount.values[min(max, index + n)];
  }

  bool get isZero => this == MineCount.zero;
}

enum CellStatus {
  flagged,
  closed,
  open,
}

class Cell {
  final int row;
  final int col;
  bool hasMine;
  MineCount minesAround;
  CellStatus status;

  Cell({
    required this.row,
    required this.col,
    this.hasMine = false,
    this.minesAround = MineCount.zero,
    this.status = CellStatus.closed,
  });

  Color get color {
    final isPrimary = !(row.isEven ^ col.isEven);

    switch (status) {
      case CellStatus.flagged:
      case CellStatus.closed:
        return isPrimary ? closedPrimaryColor : closedSecondaryColor;
      case CellStatus.open:
        return isPrimary ? openPrimaryColor : openSecondaryColor;
    }
  }

  String get text {
    switch (status) {
      case CellStatus.flagged:
        return status.name;
      case CellStatus.closed:
        return "";
      case CellStatus.open:
        if (hasMine) {
          return "mine";
        } else if (minesAround.isZero) {
          return "";
        }
        return minesAround.index.toString();
    }
  }
}

extension on (int, int) {
  Iterable<(int, int)> around(int rowCount, int columnCount) sync* {
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
      if (row < 0 || row >= rowCount || col < 0 || col >= columnCount) {
        continue;
      }
      yield pos;
    }
  }

  (int, int) operator -() => (-$1, -$2);
}

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  static const rowCount = 10;
  static const columnCount = 24;
  int mineCount = 40;

  Board board = Board.empty(rowCount, columnCount);
  bool hasBeenStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: InkWell(
          onTap: resetBoard,
          child: const CircleAvatar(
            backgroundColor: Colors.yellowAccent,
            child: Icon(
              Icons.tag_faces,
              size: 40,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
        ),
        itemCount: rowCount * columnCount,
        itemBuilder: (context, index) {
          final position = (index ~/ columnCount, index % columnCount);
          final cell = board.cellAt(position);

          return InkWell(
            onTap: () {
              if (!hasBeenStarted) {
                startGame(position);
                hasBeenStarted = true;
              }

              if (cell.hasMine && cell.status == CellStatus.closed) {
                setState(() {
                  cell.status = CellStatus.open;
                });
                _handleGameOver();
                return;
              }

              board.openCell(position);
              setState(() {});

              if (board.hasWon) {
                _handleWin();
              }
            },
            onSecondaryTap: () {
              board.toggleFlag(position);
              setState(() {});

              if (board.hasWon) {
                _handleWin();
              }
            },
            splashColor: Colors.grey,
            child: Container(
              alignment: Alignment.center,
              color: cell.color,
              child: Text(cell.text),
            ),
          );
        },
      ),
    );
  }

  void resetBoard() {
    setState(() {
      if (hasBeenStarted) {
        history.add(board.toGame());
      }

      board = Board.empty(rowCount, columnCount);
      hasBeenStarted = false;
    });
  }

  void startGame((int, int) firstClick) {
    board = Board.create(
      rowCount: rowCount,
      columnCount: columnCount,
      mineCount: mineCount,
      firstClick: firstClick,
    );

    for (final mine in board.mines) {
      board.cellAt(mine).hasMine = true;
      mine
          .around(rowCount, columnCount)
          .forEach((element) => board.cellAt(element).minesAround++);
    }

    setState(() {});
  }

  void _handleGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over!"),
          content: const Text("You stepped on a mine!"),
          actions: [
            TextButton(
              onPressed: () {
                resetBoard();
                context.pop();
              },
              child: const Text("Play again"),
            ),
          ],
        );
      },
    );
  }

  void _handleWin() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You Win!"),
          actions: [
            TextButton(
              onPressed: () {
                resetBoard();
                context.pop();
              },
              child: const Text("Play again"),
            ),
          ],
        );
      },
    );
  }
}
