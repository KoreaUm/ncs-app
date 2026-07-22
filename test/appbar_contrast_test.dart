import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ncs_app/main.dart';

void main() {
  testWidgets('AppBar has visible (non-white-on-white) styling', (tester) async {
    await tester.pumpWidget(const NcsApp());
    await tester.pump();

    final context = tester.element(find.byType(Scaffold).first);
    final appBarTheme = Theme.of(context).appBarTheme;

    expect(appBarTheme.backgroundColor, isNotNull);
    expect(appBarTheme.foregroundColor, isNotNull);
    expect(
      appBarTheme.backgroundColor,
      isNot(equals(appBarTheme.foregroundColor)),
      reason: 'AppBar background and foreground must not match, '
          'otherwise text/buttons on it become invisible.',
    );
    // Specifically guard against the bug we just fixed: a white submit
    // button rendered on an (accidentally) white/near-white app bar.
    expect(appBarTheme.backgroundColor, isNot(equals(Colors.white)));
    expect(appBarTheme.foregroundColor, equals(Colors.white));
  });
}
