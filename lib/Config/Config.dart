import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const NEARBY_STOPS_DISTANCE = "NEARBYSTOPSDISTANCE";
  static const BUS_SCHEDULE_MAX_RESULT_TIME = "BUSSCHEDULEMAXRESULTTIME";
  static const USE_24_HOUR_TIMES = "USE24HOURTIME";
  static const AUTO_REFRESH = "AUTOREFRESH";

  setNearbyStopDist(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(NEARBY_STOPS_DISTANCE, value);
  }

  Future<double> getNearbyStopDist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(NEARBY_STOPS_DISTANCE) ?? 0.5;
  }

  setBusScheduleMaxResultTime(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(BUS_SCHEDULE_MAX_RESULT_TIME, value);
  }

  Future<int> getBusScheduleMaxResultTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(BUS_SCHEDULE_MAX_RESULT_TIME) ?? 250;
  }


  setUse24HourTimes(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(USE_24_HOUR_TIMES, value);
  }

  Future<bool> getUse24HourTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(USE_24_HOUR_TIMES) ?? false;
  }

  setAutoRefresh(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AUTO_REFRESH, value);
  }

  Future<bool> getAutoRefresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AUTO_REFRESH) ?? false;
  }
}