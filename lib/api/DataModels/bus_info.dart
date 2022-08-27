import "package:transit_app/api/DataModels/bus_stop.dart";
import "package:transit_app/api/DataModels/variant.dart";
import "package:transit_app/api/DataModels/route.dart";

class BusInfo {

  BusInfo({required this.stop, required this.route,, required this.arrivalScheduled,
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
  //routeInfo being map<string, dynamic> this stores both "route" and "scheduled-stops"
  //modeled after https://api.winnipegtransit.com/v3/stops/10611/schedule.json?usage=short&api-key={apikey}&start=2022-08-26T16:20:00
  factory BusInfo.fromJson(String name, BusStop stop, Map<String, dynamic> routeInfo) {
    final Route route = Route.fromJson(routeInfo["route"]);
    final busNumber = routeInfo["scheduled-stops"][0]["bus"]["key"] as int;
    final bikeRack = routeInfo["scheduled-stops"][0]["bus"]["bike-rack"] as bool;
    final wifi = routeInfo["scheduled-stops"][0]["bus"]["wifi"] as bool;
    final cancelled = routeInfo["scheduled-stops"][0]["bus"]["cancelled"] as bool;
    final variantKey = routeInfo["scheduled-stops"][0]["bus"]["variant"]["key"] as String;
    final variantName = routeInfo["scheduled-stops"][0]["bus"]["variant"]["name"] as String;
    final Variant variant = Variant(name: variantName, key: variantKey);
    final arrivalScheduled = routeInfo["scheduled-stops"][0]["times"]["arrival"]["scheduled"] as String;
    final arrivalEstimated = routeInfo["scheduled-stops"][0]["times"]["arrival"]["estimated"] as String;
    final departureScheduled = routeInfo["scheduled-stops"][0]["times"]["departure"]["scheduled"] as String;
    final departureEstimated = routeInfo["scheduled-stops"][0]["times"]["departure"]["estimated"] as String;

    return BusInfo(stop: stop, route: route, arrivalScheduled: arrivalScheduled, arrivalEstimated: arrivalEstimated, departureEstimated: departureEstimated, departureScheduled: departureScheduled, variant: variant, busNumber: busNumber, bikeRack: bikeRack, wifi: wifi, cancelled: cancelled);
  }
}