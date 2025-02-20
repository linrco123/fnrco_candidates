// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fnrco_candidates/main.dart';


void main() {
  // group("description", () {
  //   test("description11111", () {
  //     final cal = Calculator();
  //     int num1 = 5;
  //     int num2 = 10;
  //     int result = num1 + num2;
  //     expect(cal.add(num1, num2), result);
  //   });

  //    test("description22222", () {
  //     final cal = Calculator();
  //     int num1 = 10;
  //     int num2 = 10;
  //     int result = num1 + num2;
  //     expect(cal.add(num1, num2), result);
  //   });

  //    test("description333333", () {
  //     final cal = Calculator();
  //     int num1 = 20;
  //     int num2 = 10;
  //     int result = num1 + num2;
  //     expect(cal.add(num1, num2), result);
  //   });
  // });

  // test("Test Functions In My Calculator", () {
  //   final cal = Calculator();

  //   int num1 = 5;
  //   int num2 = 10;
  //   int result = num1 + num2;

  //   expect(cal.add(num1, num2), result, reason: 'muhammed nady');
  // });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    tester.pumpWidget(const FnrcoCandidates());
    final finder1 = find.widgetWithText(Text, 'login');
    final finder2 = find.widgetWithText(TextButton, 'skip');
    

    expect(finder1, matchesGoldenFile('ererr'));
    expect(finder2, findsOneWidget);

   
    find.byWidget(Container());
    find.byType(Scrollable);
    find.byKey(const Key("value"));
    //tester.scrollUntilVisible(finder, delta,scrob);
    expect(find.text("text"), findsOneWidget);

  });
}
