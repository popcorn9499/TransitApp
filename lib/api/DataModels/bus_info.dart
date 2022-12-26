import "package:transit_app/api/DataModels/bus_stop.dart";
import "package:transit_app/api/DataModels/variant.dart";
import "package:transit_app/api/DataModels/route.dart";

class BusInfo {

  BusInfo({required this.stop, required this.route, required this.arrivalScheduled,
    required this.arrivalEstimated, required this.departureEstimated, required this.departureScheduled, required this.variant, required this.busNumber, required this.bikeRack, required this.wifi, required this.cancelled});

  final int busNumber;
  final bool bikeRack; //shows if the bus has a bike rack
  final bool wifi; //shows if the bus has wifi or not
  final bool cancelled; //shows if the bus got cancelled or not

  final BusStop stop;
  final Route route;
  final String arrivalScheduled;
  final String arrivalEstimated;
  final String departureScheduled;
  final String departureEstimated;
  final Variant variant;

  @override
  String toString() {
    String result = "Bus $route";
    result += "arrival scheduled: $arrivalScheduled arrival estimated: $arrivalEstimated ";
    result += "departure scheduled $departureScheduled departure estimated $departureEstimated ";
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
    final busNumber = routeInfo["bus"]["key"] as int;
    final bikeRack = routeInfo["bus"]["bike-rack"] == "true" ? true: false;
    final wifi = routeInfo["wifi"] == "true" ? true: false;
    final cancelled = routeInfo["cancelled"] == "true" ? true: false;
    final variantKey = routeInfo["variant"]["key"] as String;
    final variantName = routeInfo["variant"]["name"] as String;
    final Variant variant = Variant(name: variantName, key: variantKey);
    final arrivalScheduled = routeInfo["times"]["arrival"]["scheduled"] as String;
    final arrivalEstimated = routeInfo["times"]["arrival"]["estimated"] as String;
    final departureScheduled = routeInfo["times"]["departure"]["scheduled"] as String;
    final departureEstimated = routeInfo["times"]["departure"]["estimated"] as String;

    return BusInfo(stop: stop, route: route, arrivalScheduled: arrivalScheduled, arrivalEstimated: arrivalEstimated, departureEstimated: departureEstimated, departureScheduled: departureScheduled, variant: variant, busNumber: busNumber, bikeRack: bikeRack, wifi: wifi, cancelled: cancelled);
  }
}