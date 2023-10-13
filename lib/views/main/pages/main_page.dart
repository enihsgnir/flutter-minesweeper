import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/utils/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => context.pushNamed(AppRoute.leaderboard.name),
              child: const Text("Leaderboard"),
            ),
          ],
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => context.pushNamed(AppRoute.play.name),
          child: const Text("Play!"),
        ),
      ),
    );
  }
}
