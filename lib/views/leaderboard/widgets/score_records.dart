import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:flutter_minesweeper/domains/game/game_repository.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreRecords extends ConsumerStatefulWidget {
  const ScoreRecords({super.key});

  @override
  ConsumerState<ScoreRecords> createState() => _ScoreRecordsState();
}

class _ScoreRecordsState extends ConsumerState<ScoreRecords> {
  late final StreamSubscription<GameQuerySnapshot> _listener;
  @override
  void initState() {
    super.initState();

    _listener = gameRef.snapshots().listen((event) async {
      final recordsNotifier = ref.read(recordsNotifierProvider.notifier);
      recordsNotifier.state = await GameRepository().getRecords();
    });
  }

  @override
  void dispose() {
    _listener.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      difficultyNotifierProvider,
      (previous, next) async {
        ref.read(recordsNotifierProvider.notifier).state =
            await GameRepository().getRecordsByDifficulty(next);
      },
    );

    final records = ref
        .watch(recordsNotifierProvider)
        .where(
          (record) =>
              record.difficulty == ref.watch(difficultyNotifierProvider),
        )
        .toList();

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
            children: List.generate(
              10,
              (index) => RecordItem(game: null, index: index),
            ).toList(),
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
    final gameData = game;

    return Container(
      color: index.isEven ? closedPrimaryColor : closedSecondaryColor,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: gameData != null
            ? [
                Flexible(
                  child: Text(gameData.nickname),
                ),
                Flexible(
                  child: Text(gameData.playTime.toString()),
                ),
                Flexible(child: Text(gameData.createdAt.toString())),
              ]
            : [],
      ),
    );
  }
}
