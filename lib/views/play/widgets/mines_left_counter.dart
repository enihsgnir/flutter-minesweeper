import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MinesLeftCounter extends ConsumerWidget {
  const MinesLeftCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minesLeft = ref.watch(minesLeftNotifierProvider);

    return Text(
      minesLeft.toString(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
