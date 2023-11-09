import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPage extends ConsumerStatefulWidget {
  const PlayPage({super.key});

  @override
  ConsumerState<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends ConsumerState<PlayPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(logNotifierProvider);
    ref.watch(historyNotifierProvider);

    ref.listen(winStatusNotifierProvider, (previous, next) {
      if (next != null) {
        ref.read(playTimeNotifierProvider.notifier).stop();
        switch (next) {
          case WinStatus.over:
            showOverDialog();
          case WinStatus.win:
            ref.read(historyNotifierProvider.notifier).createGameRecord();
            showWinDialog();
        }
      }
    });

    final difficulty = ref.watch(playingDifficultyNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Board(difficulty: difficulty),
      ),
    );
  }

  Future<void> showOverDialog() async {
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

  Future<void> showWinDialog() async {
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
