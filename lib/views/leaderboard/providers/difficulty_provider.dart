import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'difficulty_provider.g.dart';

@riverpod
class DifficultyNotifier extends _$DifficultyNotifier {
  @override
  Difficulty build() {
    return Difficulty.easy;
  }

  void setDifficulty(String name) {
    state = Difficulty.values.byName(name);
  }
}
