import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/domains/auth/auth_repository.dart';
import 'package:flutter_minesweeper/firebase_options.dart';
import 'package:flutter_minesweeper/utils/routes.dart';
import 'package:flutter_minesweeper/views/main/main_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = await AuthRepository().signIn();

  runApp(
    ProviderScope(
      overrides: [
        userNotifierProvider.overrideWith(() => UserOverrideNotifier(user)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
