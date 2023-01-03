// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/Config/favorite_manager.dart';

import 'package:transit_app/widgets/menus/main_menu.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    FavoriteManager fm = FavoriteManager();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MainMenu(fm: fm));
    print("TESTING");
    // Verify that our counter starts at 0.
    expect(find.text('0 times'), findsOneWidget);
    expect(find.text('1 times'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0 times'), findsNothing);
    expect(find.text('1 times'), findsOneWidget);
  });
}
