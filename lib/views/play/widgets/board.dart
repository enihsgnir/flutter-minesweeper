import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const appBarColor = Color.fromRGBO(84, 116, 54, 1);

class Board extends ConsumerWidget {
  final Difficulty difficulty;

  const Board({
    super.key,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: appBarColor,
          width: difficulty.size * difficulty.colCount,
          height: 60,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MinesLeftCounter(),
              PlayTimeStopwatch(),
            ],
          ),
        ),
        SizedBox(
          width: difficulty.size * difficulty.colCount,
          height: difficulty.size * difficulty.rowCount,
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
