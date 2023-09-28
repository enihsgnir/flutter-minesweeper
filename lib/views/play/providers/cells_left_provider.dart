import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cells_left_provider.g.dart';

@riverpod
class CellsLeftNotifier extends _$CellsLeftNotifier {
  @override
  int build() {
    final config = ref.watch(boardConfigNotifierProvider);
    return config.difficulty.rowCount * config.difficulty.colCount;
  }

  void decrease() {
    state--;
  }
}
