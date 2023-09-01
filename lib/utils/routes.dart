import 'package:flutter_minesweeper/views/main_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
  ],
);
