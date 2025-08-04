/*
  A record of an individual bus stop.
  Which direction the stop is and so forth
  keeps a stop number
  stop name
  and a direction

 */

import 'dart:convert';

class BusStop {
  BusStop({required this.key,required this.number,required this.name,required this.direction,
    required this.distance, required this.longitude, required this.latitude});
  final int key;
  final int number;
  final String name;
  final String direction;
  final double distance; //walking distance to stop. this is optional and will display -1 if
  final double longitude;
  final double latitude;


  factory BusStop.fromJson(Map<String, dynamic> data) {
    final key = data['key'] as int;
    final number = data['number'] as int;
    final name = data['name'] as String;
    final direction = data['direction'] as String;
    double longitude = 0.0;
    double latitude = 0.0;
    double distance = -1;
    //handle parsing in walking distance if it in fact exists
    if (data.containsKey("distances") &&
        data["distances"].containsKey("direct")) {
      var direct = data["distances"]["direct"];
      if (direct is String) {
        distance = double.tryParse(direct) ?? 0.0;
      } else if (direct is num) {
        distance = direct.toDouble();
      }
    }

    if (data.containsKey("centre") && data["centre"].containsKey("geographic")) {
      latitude = data["centre"]["geographic"]["latitude"] as double;
      longitude = data["centre"]["geographic"]["longitude"] as double;
    }

    return BusStop(name: name, key: key,number: number, direction: direction, distance: distance, longitude: longitude, latitude: latitude);
  }

  String toJson() {
    String result = "";
    // TODO finish toJson.
    Map<String, dynamic> mapped = {
      "key": key,
      "number": number,
      "name": name,
      "direction": direction,
    };

    result = json.encode(mapped);
    return result;
  }

  @override
  String toString(){
    return "Stop #$number at $name direction $direction";
  }
}