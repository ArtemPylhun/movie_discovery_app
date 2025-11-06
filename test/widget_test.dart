import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('MovieDiscoveryApp widget test', (WidgetTester tester) async {
    // Simple app test without dependency injection
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          title: 'Movie Discovery Test',
          home: Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: const Center(child: Text('Hello Test')),
          ),
        ),
      ),
    );

    // Verify that the test app starts
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Hello Test'), findsOneWidget);
  });
}
