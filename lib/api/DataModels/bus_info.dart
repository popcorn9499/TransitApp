import "package:transit_app/api/DataModels/bus_stop.dart";
import "package:transit_app/api/DataModels/variant.dart";

class BusInfo {

  BusInfo({required this.stop, required this.routeNumber, required this.name, required this.arrivalScheduled,
    required this.arrivalEstimated, required this.departureEstimated, required this.departureScheduled, required this.variant});

  final BusStop stop;
  final String routeNumber;
  final String name;
  final String arrivalScheduled;
  final String arrivalEstimated;
  final String departureScheduled;
  final String departureEstimated;
  final Variant variant;

  @override
  String toString() {
    String result = "Bus #$routeNumber $name arrival scheduled: $arrivalScheduled arrival estimated: $arrivalEstimated ";
    result += "departure scheduled $departureScheduled departure estimated $departureEstimated ";
    result += variant.toString();
    result += " at stop ";
    result += stop.toString();
    return result;
  }

  //take the json input map and return a constructed Variants obj
  factory BusInfo.fromJson(String name, Map<String, dynamic> data) {
    Map<String, dynamic> stopData = data["stop"];
    BusStop stop = BusStop.fromJson(stopData);
    final name = data["name"] as String;
    final routeNumber = data["number"] as String;
    final


    return Variants(name: name, variants: variants);
  }
}