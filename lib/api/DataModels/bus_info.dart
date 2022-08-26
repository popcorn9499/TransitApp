import "package:transit_app/api/DataModels/bus_stop.dart";
import "package:transit_app/api/DataModels/variant.dart";
import "package:transit_app/api/DataModels/route.dart";

class BusInfo {

  BusInfo({required this.stop, required this.route, required this.arrivalScheduled,
    required this.arrivalEstimated, required this.departureEstimated, required this.departureScheduled, required this.variant});

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
  factory BusInfo.fromJson(String name, Map<String, dynamic> stopData, Map<String, dynamic> routeInfo) {
    BusStop stop = BusStop.fromJson(stopData);
    final Route route = Route.fromJson(routeInfo["route"]);
    final 


    return Variants(name: name, variants: variants);
  }
}