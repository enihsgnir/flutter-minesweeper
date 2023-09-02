import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/utils/routes.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: Center(
        child: TextButton(
          onPressed: () => context.pushNamed(AppRoute.play.name),
          child: const Text("Play!"),
        ),
      ),
    );
  }
}
