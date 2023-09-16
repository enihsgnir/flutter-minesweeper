import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DoneDialog extends ConsumerWidget {
  final String title;
  final String content;

  const DoneDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(boardStatusNotifierProvider.notifier).reset();
            context.pop();
          },
          child: const Text("Play again"),
        ),
      ],
    );
  }
}
