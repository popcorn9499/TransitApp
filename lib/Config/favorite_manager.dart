
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/DataModels/bus_stop.dart';

class FavoriteManager {
  late SharedPreferences prefs;
  List<BusStop> favorites = [];
  FavoriteManager() {
    load();
  }

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? routes = prefs.getStringList("Favorites");
    if (routes != null) {
      for (String route in routes) { //add each bus stop from the favorites file
        favorites.add(BusStop.fromJson(json.decode(route)));
      }
    } else { //set the configuration for favorites
      List<String> routes = [];
      prefs.setStringList("Favorites", routes);
    }
  }

  Future<void> save() async {
    List<String> data = [];
    for (BusStop stop in favorites) {
      data.add(stop.toJson());
    }
    prefs.setStringList("Favorites", data);
  }

  bool addFavorite(BusStop stop) {
    bool result = false;
    favorites.add(stop);
    result = favorites.contains(stop);
    save();
    return result;
  }

  bool removeFavorite(BusStop stop) {
    bool result = false;
    favorites.remove(stop);
    result = !favorites.contains(stop);
    save();
    return false;
  }
}