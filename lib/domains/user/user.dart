import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Collection<User>("users")
final userRef = UserCollectionReference();

@JsonSerializable(converters: firestoreJsonConverters)
@freezed
class User with _$User {
  const factory User({
    @Id() required String id,
    required String uid,
    required String nickname,
    required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
