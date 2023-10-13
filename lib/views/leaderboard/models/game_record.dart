import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_record.freezed.dart';

@freezed
class GameRecord with _$GameRecord {
  const factory GameRecord({
    required String nickname,
    required int playTime,
    required DateTime createdAt,
  }) = _GameRecord;
}
