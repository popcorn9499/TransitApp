/*
  A record of an individual bus stop.
  Which direction the stop is and so forth
  keeps a stop number
  stop name
  and a direction

 */

import 'dart:convert';

class BusStop {
  BusStop({required this.key,required this.number,required this.name,required this.direction});
  final int key;
  final int number;
  final String name;
  final String direction;

  factory BusStop.fromJson(Map<String, dynamic> data) {
    final key = data['key'] as int;
    final number = data['number'] as int;
    final name = data['name'] as String;
    final direction = data['direction'] as String;

    return BusStop(name: name, key: key,number: number, direction: direction);
  }

  String toJson() {
    String result = "";

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