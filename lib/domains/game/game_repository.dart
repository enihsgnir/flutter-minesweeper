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
        .orderByPlayTime()
        .whereRow(isEqualTo: difficulty.row)
        .whereCol(isEqualTo: difficulty.col)
        .limit(10)
        .get();

    for (final game in snapshot.docs) {
      final data = game.data;
      final nickname = await UserRepository().getNickname(data.userId);

      // can't find user with uid
      if (nickname == null) continue;

      // append this data in result
      result.add(
        GameRecord(
          nickname: nickname,
          playTime: data.playTime,
          createdAt: data.createdAt,
        ),
      );
    }

    return result;
  }
}
