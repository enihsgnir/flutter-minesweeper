import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String nickname,
    required int playTime,
    required Timestamp createdAt,
  }) = _Record;
}
