import 'package:flutter_minesweeper/views/leaderboard/pages/leaderboard_page.dart';
import 'package:flutter_minesweeper/views/main/main_view.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  main,
  play,
  leaderboard,
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: AppRoute.main.name,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: "/play",
      name: AppRoute.play.name,
      builder: (context, state) => const PlayPage(),
    ),
    GoRoute(
      path: "/leaderboard",
      name: AppRoute.leaderboard.name,
      builder: (context, state) => const LeaderboardPage(),
    ),
  ],
);
