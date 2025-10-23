import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

Future<String?> showNicknameUpdateDialog(BuildContext context) async {
  // TODO: dispose controller
  final controller = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Update Nickname"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "Nickname",
          ),
          maxLength: 16,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Update"),
            onPressed: () {
              context.pop(controller.text);
            },
          ),
        ],
      );
    },
  );
}
