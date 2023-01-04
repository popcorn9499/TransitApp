
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/DataModels/bus_stop.dart';

class FavoriteManager {

  List<BusStop> favorites = [];
  FavoriteManager();

  Future<void> load() async {
    print("loading");
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    print("loaded");
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

  Future<List<BusStop>> getFavorites() async {
    await load();
    return favorites;
  }

  Future<bool> isFavorited(int stopNumber ) async {
    bool result = false;
    await load();
    for (BusStop busStop in favorites) {
      result = result || (busStop.number == stopNumber);
    }
    return result;
  }

  Future<void> save() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    List<String> data = [];
    for (BusStop stop in favorites) {
      data.add(stop.toJson());
    }
    prefs.setStringList("Favorites", data);
  }

  Future<bool> addFavorite(BusStop stop) async {
    bool result = false;
    await load();
    favorites.add(stop);
    result = favorites.contains(stop);
    save();
    return result;
  }

  Future<bool> removeFavorite(BusStop stop) async {
    bool result = false;
    BusStop removeMe = stop;
    load();
    for (BusStop busStop in favorites) {
      if (stop.number == busStop.number) {
        removeMe = busStop;
        result = true;
      }
    }
    if (result) {
      favorites.remove(removeMe);
      save();
    }
    return result;
  }
}