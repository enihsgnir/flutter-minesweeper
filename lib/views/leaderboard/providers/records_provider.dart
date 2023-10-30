import 'package:flutter_minesweeper/views/leaderboard/models/game_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'records_provider.g.dart';

@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  List<GameRecord> build() {
    return [];
  }

  void clear() {
    state = [];
  }

  void addRecord(GameRecord record) {
    state = [...state, record];
  }
}
