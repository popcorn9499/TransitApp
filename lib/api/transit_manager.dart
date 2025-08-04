
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/Exceptions/network_error.dart';

import 'package:transit_app/api/url_generator.dart';
import 'package:sprintf/sprintf.dart';
import '../Config/build_config.dart';
import 'package:http/http.dart' as http;

import 'DataModels/bus_stop.dart';

class TransitManager {
  static DateFormat apiDateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static const String apiUrl = "https://api.winnipegtransit.com/v4/%s.json?usage=short&api-key=${BuildConfig.apiKey}";
  static const Duration startTimeDecrease = Duration(microseconds: 10000);

  TransitManager();


  Future<Map<String, dynamic>> getJson(String url) async {
    Map<String, dynamic> result = {"empty": 1};
    try {
      http.Response request = await http.get(Uri.parse(url));

      if (request.statusCode == 503) {
        //rate limited
      } else if (request.statusCode == 404) {
        //date not found
      }


      result = json.decode(request.body);

    } on SocketException {
      throw NetworkError("No internet access. Please connect your device to the Internet");
    } on TimeoutException {
      throw NetworkError("Connection timed out. please check your internet connection");
    }

      return result;
  }

  Future<http.Response> getRequest(String url) {
    return http.get(Uri.parse(url));
  }

  String genStopNumbersURL(String stopNumber, {List<String>? routeNumbers, DateTime? startTime, DateTime? endTime}) {
    String info = sprintf(apiUrl, ["stops/$stopNumber/schedule"]);
    URLGenerator url = URLGenerator(url: info);
    if (routeNumbers != null) {
      url.addParamList("route", routeNumbers);
    }

    if (startTime != null) {
      startTime.subtract(startTimeDecrease);
      url.addParam("start", TransitManager.apiDateFormat.format(startTime));
    }

    if (endTime != null) {
      url.addParam("end", TransitManager.apiDateFormat.format(endTime));
    }

    return url.toString();
  }

  Future<BusStopSchedules> genStopNumbers(String stopNumber, {List<String>? routeNumbers, DateTime? startTime, DateTime? endTime}) async {
    BusStopSchedules bss;
    String url = genStopNumbersURL(stopNumber, routeNumbers: routeNumbers, startTime: startTime, endTime: endTime);
    Map<String, dynamic> data = await getJson(url);
    bss = BusStopSchedules.fromJson(data);
    return bss;
  }

  String genSearchQueryURL(String search) {
    URLGenerator url = URLGenerator(url: sprintf(apiUrl, ["stops:$search"]));
    return url.toString();
  }

  Future<List<BusStop>> genSearchQuery(String search) async {
    List<BusStop> result = [];
    String url = genSearchQueryURL(search);
    Map<String, dynamic> data = await getJson(url);
    BusStop tempStop; //store the stop we are adding to the list of bus stops

    for (var element in data["stops"]) {
      tempStop = BusStop.fromJson(element);
      result.add(tempStop);
    }

    return result;
  }

  String genStopLocationURL(double long, double lat, int distance, bool walking){
    URLGenerator url = URLGenerator(url: sprintf(apiUrl, ["stops"]));
    url.addParam("lat", lat.toString());
    url.addParam("lon", long.toString());
    url.addParam("distance", distance.toString());
    url.addParam("walking", walking.toString());
    return url.toString();
  }

  Future<List<BusStop>> genStopLocations(double long, double lat, int distance) async {
    List<BusStop> busStops = [];
    BusStop busStop;

    String url = genStopLocationURL(long, lat, distance, false);
    Map<String, dynamic> data = await getJson(url);

    for (var element in data["stops"]) {
      busStop = BusStop.fromJson(element);
      busStops.add(busStop);
    }

    return busStops;
  }

}