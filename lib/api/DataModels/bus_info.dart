import "package:flutter/foundation.dart";
import "package:transit_app/api/DataModels/bus_stop.dart";
import "package:transit_app/api/DataModels/variant.dart";
import "package:transit_app/api/DataModels/route.dart";
import 'package:transit_app/api/transit_manager.dart';

import '../../bus_status.dart';

class BusInfo implements Comparable {

  BusInfo({required this.stop, required this.route, required this.arrivalScheduled,
    required this.arrivalEstimated, required this.departureEstimated, required this.departureScheduled, required this.variant, required this.busNumber, required this.bikeRack, required this.wifi, required this.cancelled});

  final int busNumber;
  final bool bikeRack; //shows if the bus has a bike rack
  final bool wifi; //shows if the bus has wifi or not
  final bool cancelled; //shows if the bus got cancelled or not

  final BusStop stop;
  final Route route;
  final DateTime arrivalScheduled;
  final DateTime arrivalEstimated;
  final DateTime departureScheduled;
  final DateTime departureEstimated;
  final Variant variant;

  BusStatus getOnTime() {
    BusStatus result = BusStatus.Ok;
    int diff = arrivalEstimated.compareTo(arrivalScheduled);
    if (cancelled) {
      result = BusStatus.Cancelled;
    } else if (diff > 0) {
      result = BusStatus.Late;
    } else if (diff < 0){
      result = BusStatus.Early;
    }
    return result;
  }
  
  @override
  String toString() {
    String result = "Bus $route";
    String arrivalScheduledStr = TransitManager.apiDateFormat.format(arrivalScheduled);
    String arrivalEstimatedStr = TransitManager.apiDateFormat.format(arrivalEstimated);
    String departureScheduledStr = TransitManager.apiDateFormat.format(departureScheduled);
    String departureEstimatedStr = TransitManager.apiDateFormat.format(departureEstimated);
    result += "arrival scheduled: $arrivalScheduledStr arrival estimated: $arrivalEstimatedStr ";
    result += "departure scheduled $departureScheduledStr departure estimated $departureEstimatedStr ";
    result += variant.toString();
    result += " at stop ";
    result += stop.toString();
    return result;
  }

  //take the json input map and return a constructed Variants obj
  //stop data being a map<string, dynamic> storing the "stop" keyword from a given json string. this includes key, name, number, direction etc
  //routeInfo being map<string, dynamic> this "scheduled-stops"[i] some specific number of the stops
  //modeled after https://api.winnipegtransit.com/v3/stops/10611/schedule.json?usage=short&api-key={apikey}&start=2022-08-26T16:20:00
  factory BusInfo.fromJson(BusStop stop, Route route, Map<String, dynamic> routeInfo) {
    int busNumber = -1;
    bool bikeRack = false;
    if (routeInfo.containsKey("bus")) { //handles transits api being stupid and not giving us this information???
      busNumber = routeInfo["bus"]["key"] as int;
      bikeRack = routeInfo["bus"]["bike-rack"] == "true" ? true : false;
    } else {
      if (kDebugMode) {
        print("WTF TRANSIT");
      }
    }
    String arrivalScheduledStr;
    String arrivalEstimatedStr;
    final wifi = routeInfo["wifi"] == "true" ? true: false;
    final cancelled = routeInfo["cancelled"] == "true" ? true: false;
    final variantKey = routeInfo["variant"]["key"] as String;
    final variantName = routeInfo["variant"]["name"] as String;
    final Variant variant = Variant(name: variantName, key: variantKey);
    String departureScheduledStr = routeInfo["times"]["departure"]["scheduled"] as String;
    String departureEstimatedStr = routeInfo["times"]["departure"]["estimated"] as String;
    if (routeInfo["times"].containsKey("arrival")) {
      arrivalScheduledStr =
      routeInfo["times"]["arrival"]["scheduled"] as String;
      arrivalEstimatedStr =
      routeInfo["times"]["arrival"]["estimated"] as String;
    } else {
      arrivalScheduledStr = departureScheduledStr;
      arrivalEstimatedStr = departureEstimatedStr;
    }


    //convert date time strings to DateTime objects
    DateTime arrivalScheduled = TransitManager.apiDateFormat.parse(arrivalScheduledStr);
    DateTime arrivalEstimated = TransitManager.apiDateFormat.parse(arrivalEstimatedStr);
    DateTime departureScheduled = TransitManager.apiDateFormat.parse(departureScheduledStr);
    DateTime departureEstimated = TransitManager.apiDateFormat.parse(departureEstimatedStr);

    return BusInfo(stop: stop, route: route, arrivalScheduled: arrivalScheduled, arrivalEstimated: arrivalEstimated, departureEstimated: departureEstimated, departureScheduled: departureScheduled, variant: variant, busNumber: busNumber, bikeRack: bikeRack, wifi: wifi, cancelled: cancelled);
  }

  String getName() {
    return variant.name;
  }

  @override
  int compareTo(other) {
    return arrivalEstimated.difference(other.arrivalEstimated).inMicroseconds;
  }
}