
import 'dart:convert';
class TransitManager {
  static const String apiDateFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static const String apiUrl = "https://api.winnipegtransit.com/v3/";

  static const List<String> defaultRouteNumbers = [];
  String apiKey = "";


  TransitManager(apiKey);


  Map<String, dynamic> getJson(String url) {
    Map<String,dynamic> result = {"empty":1};

    return result;
  }

  String genStopNumbersURL(int stopNumber, {List<String> routeNumbers = TransitManager.defaultRouteNumbers, })

  test(){


  }
}

Map<String, dynamic> test(String x){
  dynamic parsedJson = jsonDecode(x);
  return parsedJson;
}

class Restaurant {
  Restaurant({required this.name, required this.cuisine,required this.hasIndoorSeating, this.yearOpened});
  final String name;
  final String cuisine;
  final int? yearOpened;
  final bool hasIndoorSeating;

  factory Restaurant.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    final name = data['name'] as String;
    final cuisine = data['cuisine'] as String;
    final year = data['year_opened'] as int?;
    final hasIndoorSeating = data['has_indoor_seating'] as bool?;
    return Restaurant(name: name, cuisine: cuisine,hasIndoorSeating: hasIndoorSeating ?? true , yearOpened: year);
  }
}


main()
{
  var x = '{"name": "Pizza da Mario", "cuisine": "Italian" }';
  Restaurant rest = Restaurant.fromJson(test(x));
  print(rest.name);
  print(rest.cuisine);
  print(rest.yearOpened);
  print(rest.hasIndoorSeating);
}