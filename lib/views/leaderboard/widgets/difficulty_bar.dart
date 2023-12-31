import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DifficultyBar extends ConsumerWidget {
  const DifficultyBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: appBarColor,
      height: 50,
      child: Row(
        children: Difficulty.values
            .map((difficulty) => _DifficultyItem(difficulty: difficulty))
            .toList(),
      ),
    );
  }
}

class _DifficultyItem extends ConsumerWidget {
  final Difficulty difficulty;

  const _DifficultyItem({
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () async {
          ref
              .read(difficultyNotifierProvider.notifier)
              .setDifficulty(difficulty.name);
        },
        child: Center(
          child: Text(
            difficulty.name,
            style: TextStyle(
              color: (ref.watch(difficultyNotifierProvider) == difficulty)
                  ? Colors.lightBlue
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
