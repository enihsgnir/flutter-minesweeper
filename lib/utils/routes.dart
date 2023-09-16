import 'package:flutter_minesweeper/views/main_page.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  main,
  play,
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
  ],
);
