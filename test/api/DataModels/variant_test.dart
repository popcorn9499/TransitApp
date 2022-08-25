// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/variant.dart';


void main() {
  test('Test Variant Creation', () async {
    Variant variant = Variant(name: "hello",key: "goodbye");
    expect(variant.key, isNot(equals("hello")));
    expect(variant.key, equals("goodbye"));
    expect(variant.name, isNot(equals("goodbye")));
    expect(variant.name, equals("hello"));
    //not sure how to test if something isnt changable but anyways..
  });

  test('Test Variant toString', () async {
    Variant variant = Variant(name: "hello",key: "goodbye");

    expect(variant.toString(), equals("goodbye: hello"));
  });
}

