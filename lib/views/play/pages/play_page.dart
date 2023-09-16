import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const appBarColor = Color.fromRGBO(84, 116, 54, 1);

class PlayPage extends ConsumerWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(winStatusNotifierProvider, (previous, next) {
      if (next != null) {
        ref.read(playTimeNotifierProvider.notifier).stop();
        switch (next) {
          case WinStatus.over:
            showOverDialog(context);
          case WinStatus.win:
            showWinDialog(context);
        }
      }
    });

    final config = ref.watch(boardConfigNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: appBarColor,
              width: config.size * config.colCount,
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
              width: config.size * config.colCount,
              height: config.size * config.rowCount,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: config.colCount,
                children: List.generate(
                  config.rowCount * config.colCount,
                  (index) {
                    final colCount = config.colCount;
                    final pos = (index ~/ colCount, index % colCount);
                    return BoardSquare(pos);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showOverDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const DoneDialog(
          title: "Game Over!",
          content: "You stepped on a mine!",
        );
      },
    );
  }

  Future<void> showWinDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const DoneDialog(
          title: "Congratulations!",
          content: "You Win!",
        );
      },
    );
  }
}
