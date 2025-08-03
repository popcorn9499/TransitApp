// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/route.dart';


void main() {
  test('Test Route Creation', () async {
    Route route = Route(name: "cool super name", number: "123", key: "123", variantKeys: ["123", "hello"], borderColor: "#FFFFFF");
    expect(route.name, equals("cool super name"));
    expect(route.number, equals("123"));
    expect(route.key, equals("123"));

    expect(route.toString(),equals("Route name: cool super name key: 123 number: 123 variants: [123, hello]"));
  });

  test('Test Route from Json', () async {
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

    expect(route.key, equals("16"));
    expect(route.number, equals("16"));
    expect(route.name, equals("Route 16 Selkirk-Osborne"));
    List<String> v = route.getVariants();
    expect(v.length, equals(11));
    if (kDebugMode) {
      print(route.toString());
    }
    expect(route.toString(), equals("Route name: Route 16 Selkirk-Osborne key: 16 number: 16 variants: [16-0-B, 16-0-M, 16-1-P, 16-1-V, 16-1-##, 16-1-*, 16-1-L, 16-0-*, 16-1-K, 16-0-K, 16-0-s]"));
  });

  test('Test Route from Json seperated variants', () async {
    Route route = Route.fromJson({
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
      }
    }, variantsData: ["1234","567"]);

    expect(route.key, equals("16"));
    expect(route.number, equals("16"));
    expect(route.name, equals("Route 16 Selkirk-Osborne"));
    List<String> v = route.getVariants();
    expect(v.length, equals(2));
    if (kDebugMode) {
      print(route.toString());
    }
    expect(route.toString(), equals("Route name: Route 16 Selkirk-Osborne key: 16 number: 16 variants: [1234, 567]"));
  });

  test('Test Route toString', () async {
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

    expect(route.toString(), equals("Route name: Route 16 Selkirk-Osborne key: 16 number: 16 variants: [16-0-B, 16-0-M, 16-1-P, 16-1-V, 16-1-##, 16-1-*, 16-1-L, 16-0-*, 16-1-K, 16-0-K, 16-0-s]"));
  });
}

