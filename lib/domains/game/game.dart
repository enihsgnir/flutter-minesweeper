import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@Collection<Game>("games")
final gameRef = GameCollectionReference();

@freezed
class Game with _$Game {
  // ignore: invalid_annotation_target
  @JsonSerializable(converters: firestoreJsonConverters)
  const factory Game({
    @Id() required String id,
    required String userId,
    required Difficulty difficulty,
    required List<int> mineIndices,
    required List<int> logIndices,
    required int playTime,
    required DateTime createdAt,
  }) = _Game;

  const Game._();

  List<(int, int)> get mines => mineIndices.map(difficulty.toPos).toList();
  List<(int, int)> get log => logIndices.map(difficulty.toPos).toList();

  String get seed => "";

  factory Game.fromJson(Map<String, Object?> json) => _$GameFromJson(json);
}
