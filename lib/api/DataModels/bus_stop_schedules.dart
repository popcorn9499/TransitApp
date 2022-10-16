import "package:transit_app/api/DataModels/bus_stop.dart";
import 'package:transit_app/api/DataModels/bus_info.dart';
import 'package:transit_app/api/DataModels/route.dart';

class BusStopSchedules {
  BusStopSchedules({required this.schedules, required this.busStop});
  final BusStop busStop;
  final List<BusInfo> schedules;


  factory BusStopSchedules.fromJson(Map<String, dynamic> data) {
    Route route;
    List<BusInfo> busSchedules = [];
    BusStop busStop = BusStop.fromJson(data["stop"]);

    //loop over every route to find all the routes at a stop
    for (var routeSchedule in data["route-schedules"]){
      route = Route.fromJson(routeSchedule["route"]);
      //loop over every bus in each route at a stop
      for (var busSchedule in routeSchedule["scheduled-stops"]){
        busSchedules.add(BusInfo.fromJson(busStop, route, busSchedule));
      }
    }

    return BusStopSchedules(schedules: busSchedules, busStop: busStop);
  }
}