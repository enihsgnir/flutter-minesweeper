import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreRecords extends ConsumerWidget {
  const ScoreRecords({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(recordsNotifierProvider);

    return (records.isNotEmpty)
        ? Column(
            children: [
              // at most 10 records
              ...records.map(
                (game) => RecordItem(
                  game: game,
                  index: records.indexOf(game),
                ),
              ),
              // rest are null rows
              ...List.generate(
                10 - records.length,
                (index) => records.length + index,
              ).map((index) => RecordItem(game: null, index: index)),
            ],
          )
        : Column(
            children: List.generate(10, (index) => index)
                .map((index) => RecordItem(game: null, index: index))
                .toList(),
          );
  }
}

class RecordItem extends StatelessWidget {
  final GameRecord? game;
  final int index;

  const RecordItem({
    super.key,
    required this.game,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index.isEven ? closedPrimaryColor : closedSecondaryColor,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: game != null
            ? [
                Flexible(
                  child: Text(game!.nickname),
                ),
                Flexible(
                  child: Text(game!.playTime.toString()),
                ),
                Flexible(child: Text(game!.createdAt.toString())),
              ]
            : [],
      ),
    );
  }
}
