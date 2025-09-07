import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_demo_app/main.dart';

void main() {
  testWidgets('Flutter Demo App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlutterDemoApp()));
    await tester.pump();
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Home page displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlutterDemoApp()));
    await tester.pump();
    await tester.pump();

    expect(find.text('Welcome to Flutter Demo'), findsOneWidget);
    expect(find.text('Material 3'), findsOneWidget);
  });
}
