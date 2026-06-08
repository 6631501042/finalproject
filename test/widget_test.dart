// import 'package:finalproject/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('vehicle tracker login and core tabs render', (tester) async {
    await tester.pumpWidget(const MaterialApp());

    expect(find.text('MFU Vehicle Tracker'), findsOneWidget);
    expect(find.text('Continue with Lamduan Mail'), findsOneWidget);

    final loginButton = find.byKey(const ValueKey('lamduan-login-button'));
    await tester.ensureVisible(loginButton);
    await tester.pumpAndSettle();
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Vehicle Self-Tracking'), findsOneWidget);
    expect(find.text('E1 Parking'), findsWidgets);
    expect(find.text('Stationary inside guard radius'), findsOneWidget);

    await tester.tap(find.text('Vehicle'));
    await tester.pumpAndSettle();

    expect(find.text('Vehicle Profile'), findsOneWidget);
    expect(find.text('Front'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);

    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();

    expect(find.text('Route History'), findsOneWidget);
    expect(find.text('Point A to B'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Detection Settings'), findsOneWidget);
    expect(find.text('Detection start delay'), findsOneWidget);
    expect(find.text('1-2 min'), findsWidgets);
    expect(find.byType(RangeSlider), findsOneWidget);
  });
}
