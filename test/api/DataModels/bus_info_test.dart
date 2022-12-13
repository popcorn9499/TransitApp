// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_info.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';
import 'package:transit_app/api/DataModels/route.dart';
import 'package:transit_app/api/DataModels/variant.dart';


void main() {
  test('Test bus_info Creation', () async {
    BusStop busStop = BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South");
    Route route = Route(name: "cool super name", number: 123, key: 123, variantKeys: ["123", "hello"]);
    Variant variant = Variant(name:"cool super name 123", key:"123");
    BusInfo busInfo = BusInfo(stop: busStop, route: route, bikeRack: false, wifi: false, cancelled: false,
      busNumber: 666, arrivalEstimated: "2022-12-19T19:44:50", arrivalScheduled: "2022-12-19T19:44:50",
        departureEstimated: "2022-12-19T19:44:50", departureScheduled: "2022-12-19T19:44:50",
        variant: variant
    );

    expect(busInfo.busNumber, equals(666));
    expect(busInfo.bikeRack, equals(false));
    expect(busInfo.wifi, equals(false));
    expect(busInfo.cancelled, equals(false));
    expect(busInfo.stop.toString(), equals(busStop.toString()));
    expect(busInfo.route.toString(), equals(route.toString()));
    expect(busInfo.arrivalEstimated, equals("2022-12-19T19:44:50"));
    expect(busInfo.arrivalScheduled, equals("2022-12-19T19:44:50"));
    expect(busInfo.departureScheduled, equals("2022-12-19T19:44:50"));
    expect(busInfo.departureEstimated, equals("2022-12-19T19:44:50"));
    expect(busInfo.variant.toString(), equals(variant.toString()));
  });


  test('Test bus_info toString', () async {
    BusStop busStop = BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South");
    Route route = Route(name: "cool super name", number: 123, key: 123, variantKeys: ["123", "hello"]);
    Variant variant = Variant(name:"cool super name 123", key:"123");
    BusInfo busInfo = BusInfo(stop: busStop, route: route, bikeRack: false, wifi: false, cancelled: false,
        busNumber: 666, arrivalEstimated: "2022-12-19T19:44:50", arrivalScheduled: "2022-12-19T19:44:50",
        departureEstimated: "2022-12-19T19:44:50", departureScheduled: "2022-12-19T19:44:50",
        variant: variant
    );

    print(busInfo.toString());
    expect(busInfo.toString(), equals("Bus Route name: cool super name key: 123 number: 123 variants: [123, hello]arrival scheduled: 2022-12-19T19:44:50 arrival estimated: 2022-12-19T19:44:50 departure scheduled 2022-12-19T19:44:50 departure estimated 2022-12-19T19:44:50 123: cool super name 123 at stop Stop #1234 at cool stop direction South"));
  });
}
