import 'package:freezed_annotation/freezed_annotation.dart';

part 'difficulty.freezed.dart';

@freezed
class Difficulty with _$Difficulty {
  const factory Difficulty({
    required int rowCount,
    required int colCount,
    required int mineCount,
  }) = _Difficulty;

  factory Difficulty.easy() {
    return const Difficulty(
      rowCount: 8,
      colCount: 10,
      mineCount: 10,
    );
  }

  factory Difficulty.medium() {
    return const Difficulty(
      rowCount: 14,
      colCount: 18,
      mineCount: 40,
    );
  }

  factory Difficulty.hard() {
    return const Difficulty(
      rowCount: 20,
      colCount: 24,
      mineCount: 99,
    );
  }
}
