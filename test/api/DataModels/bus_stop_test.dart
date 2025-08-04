// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';


void main() {
  test('Test bus Stop Creation', () async {
    // TODO add longitude and lattitude
    BusStop busStop = BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South", distance: -1, longitude: 0, latitude: 0);

    expect(busStop.key, equals(1234));
    expect(busStop.number, equals(1234));
    expect(busStop.name, equals("cool stop"));
    expect(busStop.direction, equals("South"));
  });


  test('Test bus stop fromJson', () async {
    //copy of json from a actual api request
    BusStop busStop = BusStop.fromJson({
    "key": 10171,
    "name": "Northbound Osborne at River",
    "number": 10171,
    "direction": "Northbound",
    "side": "Farside",
    "street": {
    "key": 2715,
    "name": "Osborne Street",
    "type": "Street"
    }
    });
    expect(busStop.key, equals(10171));
    expect(busStop.number, equals(10171));
    expect(busStop.name, equals("Northbound Osborne at River"));
    expect(busStop.direction, equals("Northbound"));
    expect(busStop.toString(), equals("Stop #10171 at Northbound Osborne at River direction Northbound"));
  });

  test('Test bus Stop toString', () async {
    BusStop busStop = BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South", distance: -1, longitude: 0, latitude: 0);
    expect(busStop.toString(), equals("Stop #1234 at cool stop direction South"));
  });
}

