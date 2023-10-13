import 'package:flutter_minesweeper/domains/game/game_repository.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/leaderboard/providers/records_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'difficulty_provider.g.dart';

@riverpod
class DifficultyNotifier extends _$DifficultyNotifier {
  @override
  Difficulty build() {
    return Difficulty.easy;
  }

  void setDifficulty(String name) {
    // don't do aything if new difficulty is same with old difficulty
    if (state.name == name) return;

    final records = ref.read(recordsNotifierProvider.notifier);

    records.clear();
    state = Difficulty.values.byName(name);
    GameRepository().getRecords(state).then((value) => records.setState(value));
  }
}
