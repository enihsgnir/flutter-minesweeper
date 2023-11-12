import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'records_provider.g.dart';

@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  List<GameRecord> build() {
    return [];
  }

  @override
  set state(List<GameRecord> records) {
    state = records;
  }
}
