import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:flutter_minesweeper/domains/game/game_repository.dart';
import 'package:flutter_minesweeper/views/main/main_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  List<Game> build() {
    return [];
  }

  Game _toGame() {
    final user = ref.read(userNotifierProvider);

    final config = ref.read(boardConfigNotifierProvider);
    final mines = ref.read(minesNotifierProvider);
    final log = ref.read(logNotifierProvider);
    final time = ref.read(playTimeNotifierProvider);

    final toIndex = config.toIndex;

    return Game(
      id: "",
      userId: user.id,
      row: config.rowCount,
      col: config.colCount,
      mineIndexes: mines.map(toIndex).toList(),
      logIndexes: log.map(toIndex).toList(),
      playTime: time,
      createdAt: DateTime.now(),
    );
  }

  void writeCurrentBoard() {
    final game = _toGame();
    state = [...state, game];
  }

  Future<void> createGameRecord() async {
    final game = _toGame();
    await GameRepository().addGame(game);
  }
}
