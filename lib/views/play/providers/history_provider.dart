import 'package:flutter_minesweeper/domains/game/game.dart';
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
    final config = ref.read(boardConfigNotifierProvider);
    final mines = ref.read(minesNotifierProvider);
    final log = ref.read(logNotifierProvider);
    final time = ref.read(playTimeNotifierProvider);

    final toIndex = config.toIndex;

    return Game(
      id: "",
      userId: "",
      row: config.rowCount,
      col: config.colCount,
      mineIndice: mines.map(toIndex).toList(),
      logIndice: log.map(toIndex).toList(),
      playTime: time,
      createdAt: DateTime.now(),
    );
  }

  void writeCurrentBoard() {
    final game = _toGame();
    state = [...state, game];
  }
}
