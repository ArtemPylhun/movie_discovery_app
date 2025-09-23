import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_discovery_app/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    // Verify that the app starts
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
