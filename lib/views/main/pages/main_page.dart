import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/auth/auth_repository.dart';
import 'package:flutter_minesweeper/domains/user/user_repository.dart';
import 'package:flutter_minesweeper/utils/routes.dart';
import 'package:flutter_minesweeper/views/main/main_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${user.nickname}"),
        actions: [
          IconButton(
            onPressed: () async {
              final nickname = await showNicknameUpdateDialog(context);
              if (nickname == null || nickname.isEmpty) {
                return;
              }

              await UserRepository().updateNickname(user.id, nickname);
              ref.read(userNotifierProvider.notifier).state =
                  await AuthRepository().getCurrentUser();
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
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
