import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_4_mobile/main.dart';

void main() {
  testWidgets('Gold4App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const Gold4App());
    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
