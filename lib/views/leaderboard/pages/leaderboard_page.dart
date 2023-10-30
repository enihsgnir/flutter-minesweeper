import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/auth/auth_repository.dart';
import 'package:flutter_minesweeper/views/leaderboard/leaderboard_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 540,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  AuthRepository().signIn();
                },
                child: const Text("login"),
              ),
              const DifficultyBar(),
              const ScoreRecords(),
            ],
          ),
        ),
      ),
    );
  }
}
