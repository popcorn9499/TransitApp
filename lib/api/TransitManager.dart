
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:transit_app/api/URLGenerator.dart';
import 'package:sprintf/sprintf.dart';
import '../Config/BuildConfig.dart';
import 'package:http/http.dart' as http;

class TransitManager {
  static DateFormat apiDateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static const String apiUrl = "https://api.winnipegtransit.com/v3/%s.json?usage=short&api-key=${BuildConfig.apiKey}";
  static const Duration startTimeDecrease = Duration(microseconds: 10000);

  TransitManager();


  Map<String, dynamic> getJson(String url) {
    Map<String, dynamic> result = {"empty": 1};

    late Future<http.Response> requestAsync = http.get(Uri.parse(url));
    http.Response? request;

    requestAsync.then((data) {
      request = data;
    });
    if (request?.statusCode == 503) {
      //rate limited
    } else if (request?.statusCode == 404) {
      //date not found
    }

    if (request?.body != null) {
      result = json.decode(request?.body??"");
    }
      return result;
  }
  Future<http.Response> getRequest(String url) {
    return http.get(Uri.parse(url));
  }

  String genStopNumbersURL(int stopNumber, {List<String>? routeNumbers, DateTime? startTime, DateTime? endTime}) {
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

  String genSearchQuery(String search) {
    URLGenerator url = URLGenerator(url: "stops:$search");

    return url.toString();
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