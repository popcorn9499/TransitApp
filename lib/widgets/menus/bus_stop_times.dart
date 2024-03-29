import 'package:flutter/material.dart';
import 'package:transit_app/Config/favorite_manager.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/widgets/bus_list_tile.dart';
import 'package:http/http.dart' as http;

import '../../api/DataModels/bus_info.dart';
import '../../api/DataModels/bus_stop.dart';
import '../widgets/error_snackbar.dart';
import '../widgets/layout_stop_times_header.dart';
import '../widgets/popup_menu.dart';
import '../widgets/refreshing_snackbar.dart';

class BusStopTimes extends StatefulWidget {
  final int searchNumber;
  const BusStopTimes({required this.searchNumber, Key? key}) : super(key: key);

  @override
  BusStopTimesListState createState() => BusStopTimesListState();
}

class BusStopTimesListState extends State<BusStopTimes> {
  var newList = <BusListTile>[];

  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  BusStopTimesListState();
  late ErrorSnackBar errorPrompt;
  late BusStop busStop;
  Icon favoriteIcon = const Icon(Icons.favorite_border_outlined);

  @override
  initState() {
    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
    FavoriteManager fm = FavoriteManager();
    Future<bool> future = fm.isFavorited(widget.searchNumber);
    future.then((result) {
      if (result) {
        favoriteIcon = const Icon(Icons.favorite);
      }
    });
    print("Loading bus stop times");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshStopList()); //run a start item on startup
  }

  Future<void> _refreshStopList() async {
    ScaffoldMessenger.of(context).showSnackBar(const RefreshingSnackbar());
    print("Reloading stop list");
    TransitManager tm = TransitManager();
    try {
      print("getting stop information");
      BusStopSchedules info = await tm.genStopNumbers(
          widget.searchNumber.toString());

      newList.clear();
      print("Parsing stop information");
      BusStopSchedules bss = info;
      routeName = bss.busStop.name;
      busStop = bss.busStop;
      lookupTime = DateTime.now();
      for (BusInfo bi in bss
          .schedules) { //loop over the busInfo list to parse that data

        print("adding stop item to display");
        //create and add the new object to the list
        newList.add(BusListTile(bi, lookupTime));
      }

      //unsure what this is for? something to do with updating the listview
    //
    } catch(e) {
      errorPrompt.onError(e);
    }
    setState(() {});
    print("Finished");
  }

  Future<void> toggleFavorite() async {
    print("toggling favorite");
    FavoriteManager fm = FavoriteManager();
    bool isFavorited = await fm.isFavorited(widget.searchNumber);
    if (isFavorited) {
      favoriteIcon = const Icon(Icons.favorite_border_outlined);
      await fm.removeFavorite(busStop);
      setState(() {
        favoriteIcon = const Icon(Icons.favorite_border_outlined);
      });
    } else {
      favoriteIcon = const Icon(Icons.favorite);
      await fm.addFavorite(busStop);
      setState(() {
        favoriteIcon = const Icon(Icons.favorite);
      });
    }
    print("Setting icon");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stop ${widget.searchNumber}"),
        actions: [
          FloatingActionButton(
              onPressed: toggleFavorite, child: favoriteIcon),
          FloatingActionButton(
              onPressed: _refreshStopList, child: const Icon(Icons.refresh)),
          PopupMenu(),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                _refreshStopList();
              });
            });
          },
          child: Column(children: <Widget>[
            LayoutStopTimesHeader(routeName: routeName, time: lookupTime),
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
