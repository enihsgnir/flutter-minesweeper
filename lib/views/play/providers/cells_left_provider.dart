import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cells_left_provider.g.dart';

@riverpod
class CellsLeftNotifier extends _$CellsLeftNotifier {
  @override
  int build() {
    final config = ref.watch(boardConfigNotifierProvider);
    return config.rowCount * config.colCount;
  }

  void decrease() {
    state--;
  }
}
