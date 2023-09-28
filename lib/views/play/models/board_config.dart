import 'package:flutter/foundation.dart';
import 'package:flutter_minesweeper/models/difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_config.freezed.dart';

@freezed
class BoardConfig with _$BoardConfig {
  const factory BoardConfig({
    required Difficulty difficulty,
    required double size,
  }) = _BoardConfig;

  factory BoardConfig.easy() {
    return BoardConfig(
      difficulty: Difficulty.easy(),
      size: 50,
    );
  }

  factory BoardConfig.medium() {
    return BoardConfig(
      difficulty: Difficulty.medium(),
      size: 30,
    );
  }

  factory BoardConfig.hard() {
    return BoardConfig(
      difficulty: Difficulty.hard(),
      size: 25,
    );
  }
}
