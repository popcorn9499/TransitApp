// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';
import 'package:transit_app/api/DataModels/variant.dart';


void main() {
  test('Test bus Stop Creation', () async {
    BusStop busStop = BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South");

    expect(busStop.key, equals(1234));
    expect(busStop.number, equals(1234));
    expect(busStop.name, equals("cool stop"));
    expect(busStop.direction, equals("South"));
  });

  test('Test bus Stop toString', () async {
    BusStop busStop = BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South");
    expect(busStop.toString(), equals("Stop #1234 at cool stop direction South"));
  });
}

