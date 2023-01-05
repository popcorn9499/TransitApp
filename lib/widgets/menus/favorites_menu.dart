import 'package:flutter/material.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/widgets/bus_list_tile.dart';
import 'package:http/http.dart' as http;
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../Config/favorite_manager.dart';
import '../../api/DataModels/bus_info.dart';
import '../../api/DataModels/bus_stop.dart';
import '../widgets/bus_stop_list_tile.dart';
import '../widgets/layout_stop_times_header.dart';

class FavoritesMenu extends StatefulWidget {
  const FavoritesMenu({Key? key}) : super(key: key);

  @override
  FavoritesMenuListState createState() => FavoritesMenuListState();
}

class FavoritesMenuListState extends State<FavoritesMenu> {
  var newList = <BusStopListTile>[];
  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  late ErrorSnackBar errorPrompt;

  FavoritesMenuListState();


  @override
  initState() {
    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadFavoritesList()); //run a start item on startup
  }

  Future<void> loadFavoritesList() async {
    newList.clear();
    FavoriteManager fm = FavoriteManager();
    BusStopListTile busStopTile;
    List<BusStop> favorites = await fm.getFavorites();

    for (BusStop busStop in favorites) {
      busStopTile = BusStopListTile(busStop: busStop);
      newList.add(busStopTile);
    }
    //unsure what this is for? something to do with updating the listview
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        actions: [
          FloatingActionButton(
              onPressed: loadFavoritesList, child: const Icon(Icons.menu)),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                loadFavoritesList();
              });
            });
          },
          child: Column(children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: newList.length,
                itemBuilder: (context, index) => _buildRow(index),
              ),
            ),
          ])),
    );
  }

  //actually manages to return the BusListTile object for the user interface
  _buildRow(int index) {
    return newList[index];
  }
}
