import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/main.dart';
import 'package:flutter_minesweeper/views/play/play_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Finder boardSquareAt((int, int) pos) {
  return find.byWidgetPredicate(
    (widget) => widget is BoardSquare && widget.pos == pos,
  );
}

void main() {
  testWidgets("play page test", (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MainApp()));

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text("Play!"), findsOneWidget);

    await tester.tap(find.text("Play!"));
    await tester.pumpAndSettle();
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(BoardSquare), findsWidgets);

    final firstSquare = boardSquareAt((0, 0));

    await tester.tap(firstSquare, buttons: kSecondaryButton);
    await tester.pump();
    expect(find.byIcon(Icons.flag), findsOneWidget);

    await tester.tap(firstSquare, buttons: kSecondaryButton);
    await tester.pump();
    expect(find.byIcon(Icons.flag), findsNothing);

    await tester.tap(firstSquare);
    await tester.pump();
    expect(
      find.descendant(
        of: firstSquare,
        matching: find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == openPrimaryColor,
        ),
      ),
      findsOneWidget,
    );
  });
}
