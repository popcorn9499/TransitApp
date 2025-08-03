// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_info.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';
import 'package:transit_app/api/DataModels/route.dart';
import 'package:transit_app/api/DataModels/variant.dart';
import 'package:transit_app/api/transit_manager.dart';

void main() {
  test('Test bus_info Creation', () async {
    BusStop busStop =
        BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South", distance: -1);
    Route route = Route(
        name: "cool super name",
        number: "123",
        key: "123",
        variantKeys: ["123", "hello"],
        borderColor: "#FFFFFF"
    );
    Variant variant = Variant(name: "cool super name 123", key: "123");
    BusInfo busInfo = BusInfo(
        stop: busStop,
        route: route,
        bikeRack: false,
        wifi: false,
        cancelled: false,
        busNumber: 666,
        arrivalEstimated: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        arrivalScheduled: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        departureEstimated: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        departureScheduled: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        variant: variant);

    expect(busInfo.busNumber, equals(666));
    expect(busInfo.bikeRack, equals(false));
    expect(busInfo.wifi, equals(false));
    expect(busInfo.cancelled, equals(false));
    expect(busInfo.stop.toString(), equals(busStop.toString()));
    expect(busInfo.route.toString(), equals(route.toString()));
    expect(TransitManager.apiDateFormat.format(busInfo.arrivalEstimated), equals("2022-12-19T19:44:50"));
    expect(TransitManager.apiDateFormat.format(busInfo.arrivalScheduled), equals("2022-12-19T19:44:50"));
    expect(TransitManager.apiDateFormat.format(busInfo.departureScheduled), equals("2022-12-19T19:44:50"));
    expect(TransitManager.apiDateFormat.format(busInfo.departureEstimated), equals("2022-12-19T19:44:50"));
    expect(busInfo.variant.toString(), equals(variant.toString()));
  });

  test('Test bus_info fromJson', () async {
    BusStop stop = BusStop.fromJson({
      "key": 10171,
      "name": "Northbound Osborne at River",
      "number": 10171,
      "direction": "Northbound",
      "side": "Farside",
      "street": {"key": 2715, "name": "Osborne Street", "type": "Street"},
      "cross-street": {"key": 3057, "name": "River Avenue", "type": "Avenue"},
      "centre": {
        "utm": {"zone": "14U", "x": 633163, "y": 5526878},
        "geographic": {"latitude": "49.87948", "longitude": "-97.1465"}
      }
    });
    Route route = Route.fromJson({
      "route": {
        "key": 16,
        "number": 16,
        "name": "Route 16 Selkirk-Osborne",
        "customer-type": "regular",
        "coverage": "regular",
        "badge-label": 16,
        "badge-style": {
          "class-names": {
            "class-name": [
              "badge-label",
              "regular"
            ]
          },
          "background-color": "#ffffff",
          "border-color": "#d9d9d9",
          "color": "#000000"
        },
        "variants": [
          {
            "key": "16-0-B"
          },
          {
            "key": "16-0-M"
          },
          {
            "key": "16-1-P"
          },
          {
            "key": "16-1-V"
          },
          {
            "key": "16-1-##"
          },
          {
            "key": "16-1-*"
          },
          {
            "key": "16-1-L"
          },
          {
            "key": "16-0-*"
          },
          {
            "key": "16-1-K"
          },
          {
            "key": "16-0-K"
          },
          {
            "key": "16-0-s"
          }
        ]
      },
      "query-time": "2022-12-12T19:16:24"
    });
    BusInfo busInfo = BusInfo.fromJson(stop, route, {
      "key": "22344952-37",
      "cancelled": "false",
      "times": {
        "arrival": {
          "scheduled": "2022-12-12T23:25:20",
          "estimated": "2022-12-12T23:25:20"
        },
        "departure": {
          "scheduled": "2022-12-12T23:25:20",
          "estimated": "2022-12-12T23:25:20"
        }
      },
      "variant": {
        "key": "16-0-M",
        "name": "Via Manitoba"
      },
      "bus": {
        "key": 823,
        "bike-rack": "true",
        "wifi": "false"
      }
    });

    expect(busInfo.bikeRack, equals(true));
    expect(busInfo.wifi, equals(false));
    expect(busInfo.cancelled, equals(false));
    if (kDebugMode) {
      print(busInfo.toString());
    }
    expect(busInfo.toString(), equals("Bus Route name: Route 16 Selkirk-Osborne key: 16 number: 16 variants: [16-0-B, 16-0-M, 16-1-P, 16-1-V, 16-1-##, 16-1-*, 16-1-L, 16-0-*, 16-1-K, 16-0-K, 16-0-s]arrival scheduled: 2022-12-12T23:25:20 arrival estimated: 2022-12-12T23:25:20 departure scheduled 2022-12-12T23:25:20 departure estimated 2022-12-12T23:25:20 16-0-M: Via Manitoba at stop Stop #10171 at Northbound Osborne at River direction Northbound"));
  });

  test('Test bus_info toString', () async {
    BusStop busStop =
        BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South", distance: -1);
    Route route = Route(
        name: "cool super name",
        number: "123",
        key: "123",
        variantKeys: ["123", "hello"],
        borderColor: "#FFFFFF");
    Variant variant = Variant(name: "cool super name 123", key: "123");
    BusInfo busInfo = BusInfo(
        stop: busStop,
        route: route,
        bikeRack: false,
        wifi: false,
        cancelled: false,
        busNumber: 666,
        arrivalEstimated: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        arrivalScheduled: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        departureEstimated: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        departureScheduled: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        variant: variant);

    if (kDebugMode) {
      print(busInfo.toString());
    }
    expect(
        busInfo.toString(),
        equals(
            "Bus Route name: cool super name key: 123 number: 123 variants: [123, hello]arrival scheduled: 2022-12-19T19:44:50 arrival estimated: 2022-12-19T19:44:50 departure scheduled 2022-12-19T19:44:50 departure estimated 2022-12-19T19:44:50 123: cool super name 123 at stop Stop #1234 at cool stop direction South"));
  });
}
