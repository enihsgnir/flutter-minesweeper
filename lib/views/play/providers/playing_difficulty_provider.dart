import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playing_difficulty_provider.g.dart';

@riverpod
class PlayingDifficultyNotifier extends _$PlayingDifficultyNotifier {
  @override
  Difficulty build() {
    return Difficulty.medium;
  }
}
