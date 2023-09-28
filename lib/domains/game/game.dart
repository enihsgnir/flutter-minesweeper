import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/foundation.dart';
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
    required int row,
    required int col,
    required List<int> mineIndice,
    required List<int> logIndice,
    required DateTime createdAt,
    required int playTime,
  }) = _Game;

  const Game._();

  List<(int, int)> get mines =>
      mineIndice.map((e) => (e ~/ col, e % col)).toList();

  List<(int, int)> get log => logIndice
      .map((e) => (e.sign * (e.abs() ~/ col), e.sign * (e.abs() % col)))
      .toList();

  String get seed => "";

  factory Game.fromJson(Map<String, Object?> json) => _$GameFromJson(json);
}
