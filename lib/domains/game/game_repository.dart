import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:flutter_minesweeper/domains/user/user_repository.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';

class GameRepository {
  Future<void> addGame(Game game) async {
    gameRef.add(game);
    return;
  }

  Future<List<GameRecord>> getRecords(Difficulty difficulty) async {
    final result = <GameRecord>[];

    final snapshot = await gameRef
        .whereRow(isEqualTo: difficulty.row)
        .whereCol(isEqualTo: difficulty.col)
        .orderByPlayTime()
        .limit(10)
        .get();

    for (final game in snapshot.docs.map((e) => e.data)) {
      final nickname = await UserRepository().getNickname(game.userId);

      // can't find user with uid
      if (nickname == null) {
        continue;
      }

      // append this data in result
      result.add(
        GameRecord(
          nickname: nickname,
          playTime: game.playTime,
          createdAt: game.createdAt,
        ),
      );
    }

    return result;
  }
}
