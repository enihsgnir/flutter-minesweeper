import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayTimeStopwatch extends ConsumerWidget {
  const PlayTimeStopwatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(playTimeNotifierProvider);

    return Text(
      time,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
