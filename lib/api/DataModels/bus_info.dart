import "package:transit_app/api/DataModels/bus_stop.dart";
import "package:transit_app/api/DataModels/variant.dart";

class BusInfo {

  BusInfo({required this.stop, required this.number, required this.name, required this.arrivalScheduled,
    required this.arrivalEstimated, required this.departureEstimated, required this.departureScheduled, required this.variant});

  final BusStop stop;
  final int number;
  final String name;
  final String arrivalScheduled;
  final String arrivalEstimated;
  final String departureScheduled;
  final String departureEstimated;
  final Variant variant;

  @override
  String toString() {
    String result = "Bus #$number $name arrival scheduled: $arrivalScheduled arrival estimated: $arrivalEstimated ";
    result += "departure scheduled $departureScheduled departure estimated $departureEstimated ";
    result += variant.toString();
    result += " at stop ";
    result += stop.toString();
    return result;
  }
}