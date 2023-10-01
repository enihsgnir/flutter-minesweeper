import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/leaderboard/widgets/difficulty_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: SizedBox(
          width: 540,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DifficultyBar(),
            ],
          ),
        ),
      ),
    );
  }
}
