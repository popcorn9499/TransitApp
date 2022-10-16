import "package:transit_app/api/DataModels/bus_stop.dart";
import 'package:transit_app/api/DataModels/bus_info.dart';


class BusStopSchedules {
  BusStopSchedules({required this.schedules, required this.busStop});
  final BusStop busStop;
  final List<BusInfo> schedules;



}