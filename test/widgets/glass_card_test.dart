import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundit_app/src/widgets/glass_card.dart';

/// Widget tests for GlassCard
void main() {
  group('GlassCard Widget Tests', () {
    testWidgets('GlassCard renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassCard(
              child: Text('Test Content'),
            ),
          ),
        ),
      );
      
      expect(find.text('Test Content'), findsOneWidget);
    });
    
    testWidgets('GlassCard responds to tap', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () => tapped = true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );
      
      await tester.tap(find.text('Tap Me'));
      expect(tapped, true);
    });
  });
}
