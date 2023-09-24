import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardSquare extends ConsumerWidget {
  final (int, int) pos;

  const BoardSquare(
    this.pos, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cell = ref.watch(cellNotifierProvider(pos));
    final boardStatus = ref.watch(boardStatusNotifierProvider);

    return InkWell(
      onTap: () {
        if (boardStatus == BoardStatus.ready) {
          ref.read(minesNotifierProvider.notifier).generate(pos);
          ref.read(boardStatusNotifierProvider.notifier).next();
          ref.read(playTimeNotifierProvider.notifier).start();
        }

        if (cell.status != CellStatus.closed) {
          return;
        }

        if (cell.hasMine) {
          ref.read(cellNotifierProvider(pos).notifier).setOpen();
          ref.read(logNotifierProvider.notifier).add(pos);
        } else {
          ref.read(cellNotifierProvider(pos).notifier).open();
        }
      },
      onSecondaryTap: () {
        ref.read(cellNotifierProvider(pos).notifier).toggle();
      },
      splashColor: Colors.grey,
      child: Container(
        alignment: Alignment.center,
        color: cell.color,
        child: cell.widget,
      ),
    );
  }
}
