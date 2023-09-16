import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_config.freezed.dart';

@freezed
class BoardConfig with _$BoardConfig {
  const factory BoardConfig({
    required int rowCount,
    required int colCount,
    required int mineCount,
    required double size,
  }) = _BoardConfig;

  factory BoardConfig.easy() {
    return const BoardConfig(
      rowCount: 8,
      colCount: 10,
      mineCount: 10,
      size: 50,
    );
  }

  factory BoardConfig.medium() {
    return const BoardConfig(
      rowCount: 14,
      colCount: 18,
      mineCount: 40,
      size: 30,
    );
  }

  factory BoardConfig.hard() {
    return const BoardConfig(
      rowCount: 20,
      colCount: 24,
      mineCount: 99,
      size: 25,
    );
  }
}
