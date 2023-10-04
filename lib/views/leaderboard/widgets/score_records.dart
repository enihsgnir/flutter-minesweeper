import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/game/game.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreRecords extends ConsumerWidget {
  const ScoreRecords({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(difficultyNotifierProvider);

    return FirestoreBuilder<GameQuerySnapshot>(
      ref: gameRef
          .whereRow(isEqualTo: difficulty.row)
          .whereCol(isEqualTo: difficulty.col)
          .limit(10),
      builder: (context, snapshot, child) {
        if (snapshot.hasError) {
          return Container(
            color: closedPrimaryColor,
            width: double.infinity,
            height: 400,
            child: const Center(
              child: Text("error"),
            ),
          );
        }
        if (!snapshot.hasData) return const Text("Loading...");

        final docs = snapshot.data!.docs;
        return Column(
          children: [
            // at most 10 records
            ...docs.map(
              (game) => RecordItem(
                game: game.data,
                index: docs.indexOf(game),
              ),
            ),
            // rest are null rows
            ...List.generate(
              10 - docs.length,
              (index) => docs.length + index,
            ).map((index) => RecordItem(game: null, index: index)),
          ],
        );
      },
    );
  }
}

class RecordItem extends StatelessWidget {
  final Game? game;
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
                Text(game!.userId),
                Text(game!.playTime.toString()),
                Text(game!.createdAt.toString()),
              ]
            : [],
      ),
    );
  }
}
