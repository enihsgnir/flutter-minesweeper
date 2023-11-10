import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayingDifficultySelector extends ConsumerWidget {
  final Difficulty? fixAt;

  const PlayingDifficultySelector({
    super.key,
    this.fixAt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(playingDifficultyNotifierProvider);

    return DropdownButton(
      value: fixAt ?? difficulty,
      items: Difficulty.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name),
            ),
          )
          .toList(),
      onChanged: fixAt != null
          ? null
          : (Difficulty? value) {
              if (value != null) {
                ref.read(boardStatusNotifierProvider.notifier).reset();
                ref.read(playingDifficultyNotifierProvider.notifier).state =
                    value;
              }
            },
    );
  }
}
