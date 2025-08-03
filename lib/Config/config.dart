import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const nearbyStopsDistance = "NEARBYSTOPSDISTANCE";
  static const busScheduleMaxResultTime = "BUSSCHEDULEMAXRESULTTIME";
  static const use24HourTimes = "USE24HOURTIME";
  static const autoRefresh = "AUTOREFRESH";

  setNearbyStopDist(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(nearbyStopsDistance, value);
  }

  Future<double> getNearbyStopDist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(nearbyStopsDistance) ?? 400;
  }

  setBusScheduleMaxResultTime(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(busScheduleMaxResultTime, value);
  }

  Future<int> getBusScheduleMaxResultTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(busScheduleMaxResultTime) ?? 2;
  }


  setUse24HourTimes(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(use24HourTimes, value);
  }

  Future<bool> getUse24HourTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(use24HourTimes) ?? false;
  }

  setAutoRefresh(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(autoRefresh, value);
  }

  Future<bool> getAutoRefresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(autoRefresh) ?? false;
  }
}