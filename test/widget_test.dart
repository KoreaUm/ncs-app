import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ncs_app/main.dart';

void main() {
  testWidgets('Home screen renders entry actions', (WidgetTester tester) async {
    await tester.pumpWidget(const NcsApp());
    await tester.pump();

    expect(find.text('NCS 직업기초능력 훈련'), findsOneWidget);
    expect(find.text('게스트로 시작하기'), findsOneWidget);
    expect(find.byIcon(Icons.school), findsOneWidget);
  });
}
