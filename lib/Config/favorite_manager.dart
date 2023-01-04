
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/DataModels/bus_stop.dart';

class FavoriteManager {

  FavoriteManager();

  Future<List<BusStop>> load() async {
    print("loading");
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    List<BusStop> favorites = []; //reset the favorites list back to blank before continuing
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
    return favorites;
  }

  Future<List<BusStop>> getFavorites() async {
    return await load();
  }

  Future<bool> isFavorited(int stopNumber ) async {
    bool result = false;
    List<BusStop> favorites = await load();
    for (BusStop busStop in favorites) {
      result = result || (busStop.number == stopNumber);
    }
    return result;
  }

  Future<void> save(List<BusStop> favorites) async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    List<String> data = [];
    for (BusStop stop in favorites) {
      data.add(stop.toJson());
    }
    prefs.setStringList("Favorites", data);
  }

  Future<bool> addFavorite(BusStop stop) async {
    bool result = false;
    List<BusStop> favorites = await load();
    favorites.add(stop);
    result = favorites.contains(stop);
    await save(favorites);
    return result;
  }

  Future<bool> removeFavorite(BusStop stop) async {
    bool result = false;
    //BusStop removeMe = stop;
    List<BusStop> favorites = await load();
    List<BusStop> favoritesCpy = favorites.toList();
    
    for (BusStop busStop in favoritesCpy) {
      if (stop.number == busStop.number) {
        favorites.removeWhere((element) => element == busStop);
        result = true;
      }
    }
    await save(favorites);
    return result;
  }
}