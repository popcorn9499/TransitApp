// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/URLGenerator.dart';


void main() {
  test('Test URlGenerator Creation Simple', () async {
    URLGenerator generator = URLGenerator(url: "www.cool.com");
    expect(generator.toString(), equals("www.cool.com"));
  });

  test('Test URlGenerator Creation parameters', () async {
    URLGenerator generator = URLGenerator(url: "www.cool.com");
    generator.addParam("type", "fancy");
    expect(generator.toString(), equals("www.cool.com&type=fancy"));
  });

  test('Test URlGenerator Creation parameters List', () async {
    URLGenerator generator = URLGenerator(url: "www.cool.com");
    generator.addParamList("type", ["fancy", "simple"]);
    expect(generator.toString(), equals("www.cool.com&type=fancy&type=simple"));
  });

  test('Test URlGenerator Creation parameters spaces', () async {
    URLGenerator generator = URLGenerator(url: "www.cool.com");
    generator.addParam("type", "fancy coolness");
    expect(generator.toString(), equals("www.cool.com&type=fancy+coolness"));
  });

  test('Test URlGenerator Creation parameters List spaces', () async {
    URLGenerator generator = URLGenerator(url: "www.cool.com");
    generator.addParamList("type", ["fancy", "simple coolness"]);
    expect(generator.toString(), equals("www.cool.com&type=fancy&type=simple+coolness"));
  });
}
