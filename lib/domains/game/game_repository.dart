import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:flutter_minesweeper/domains/user/user_repository.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';

class GameRepository {
  Future<void> addGame(Game game) async {
    gameRef.add(game);
    return;
  }

  Future<List<GameRecord>> getRecords() async {
    final result = <GameRecord>[];

    final snapshot = await gameRef.orderByPlayTime().limit(10).get();

    for (final game in snapshot.docs.map((e) => e.data)) {
      final user = await UserRepository().getById(game.userId);

      // can't find user
      if (user == null) {
        continue;
      }

      // append this data in result
      result.add(
        GameRecord(
          nickname: user.nickname,
          playTime: game.playTime,
          difficulty: game.difficulty,
          createdAt: game.createdAt,
        ),
      );
    }

    return result;
  }
}
