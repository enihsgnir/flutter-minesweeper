import 'package:flutter/widgets.dart';
import 'package:flutter_minesweeper/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("provider container test", (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MainApp()));

    final context = tester.element(find.byType(MainApp));
    expect(context, isA<BuildContext>());

    final container = ProviderScope.containerOf(context);

    final ftProvider = Provider((ref) => 42);
    expect(container.read(ftProvider), equals(42));
  });
}
