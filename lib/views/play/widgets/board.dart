import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const appBarColor = Color.fromRGBO(84, 116, 54, 1);

class Board extends ConsumerWidget {
  final Difficulty difficulty;
  final bool fromGame;

  const Board({
    super.key,
    required this.difficulty,
  }) : fromGame = false;

  Board.ofGame(Game game)
      : difficulty = game.difficulty,
        fromGame = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: appBarColor,
          width: difficulty.width,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlayingDifficultySelector(fixAt: fromGame ? difficulty : null),
              const MinesLeftCounter(),
              const PlayTimeStopwatch(),
            ],
          ),
        ),
        SizedBox(
          width: difficulty.width,
          height: difficulty.height,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: difficulty.colCount,
            children: List.generate(
              difficulty.rowCount * difficulty.colCount,
              (index) {
                final pos = difficulty.toPos(index);
                return BoardSquare(pos);
              },
            ),
          ),
        ),
      ],
    );
  }
}
