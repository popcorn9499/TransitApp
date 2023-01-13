
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/Exceptions/NetworkError.dart';

import 'package:transit_app/api/URLGenerator.dart';
import 'package:sprintf/sprintf.dart';
import '../Config/BuildConfig.dart';
import 'package:http/http.dart' as http;

import 'DataModels/bus_stop.dart';

class TransitManager {
  static DateFormat apiDateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static const String apiUrl = "https://api.winnipegtransit.com/v3/%s.json?usage=short&api-key=${BuildConfig.apiKey}";
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
    } on TimeoutException catch (e) {
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

  Future<BusStopSchedules> genStopNumbers(String stopNumber, {List<String>? routeNumbers, DateTime? startTime, DateTime? endTime}) async{
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





//
// Map<String, dynamic> test(String x){
//   dynamic parsedJson = jsonDecode(x);
//   return parsedJson;
// }

// class Restaurant {
//   Restaurant({required this.name, required this.cuisine,required this.hasIndoorSeating, this.yearOpened});
//   final String name;
//   final String cuisine;
//   final int? yearOpened;
//   final bool hasIndoorSeating;
//
//   factory Restaurant.fromJson(Map<String, dynamic> data) {
//     // note the explicit cast to String
//     // this is required if robust lint rules are enabled
//     final name = data['name'] as String;
//     final cuisine = data['cuisine'] as String;
//     final year = data['year_opened'] as int?;
//     final hasIndoorSeating = data['has_indoor_seating'] as bool?;
//     return Restaurant(name: name, cuisine: cuisine,hasIndoorSeating: hasIndoorSeating ?? true , yearOpened: year);
//   }
// }


// main()
// {
//   var x = '{"name": "Pizza da Mario", "cuisine": "Italian" }';
//   Restaurant rest = Restaurant.fromJson(test(x));
//   print(rest.name);
//   print(rest.cuisine);
//   print(rest.yearOpened);
//   print(rest.hasIndoorSeating);
// }