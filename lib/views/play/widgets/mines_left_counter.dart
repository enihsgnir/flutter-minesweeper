import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MinesLeftCounter extends ConsumerWidget {
  const MinesLeftCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(boardStatusNotifierProvider);
    final config = ref.watch(boardConfigNotifierProvider);
    final minesLeft = ref.watch(minesLeftNotifierProvider);

    final count =
        status == BoardStatus.ready ? config.difficulty.mineCount : minesLeft;

    return Text(
      count.toString(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
