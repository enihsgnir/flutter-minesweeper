import 'package:flutter_minesweeper/domains/game/game.dart';

class GameRepository {
  Future<void> addGame(Game game) async {
    gameRef.add(game);
    return;
  }
}
