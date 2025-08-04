import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transit_app/Config/favorite_manager.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/transit_manager.dart';
import 'package:transit_app/widgets/menus/bus_stop_info.dart';
import 'package:transit_app/widgets/widgets/bus_list_tile.dart';

import '../../Config/config.dart';
import '../../api/DataModels/bus_info.dart';
import '../../api/DataModels/bus_stop.dart';
import '../widgets/error_snackbar.dart';
import '../widgets/layout_stop_times_header.dart';
import '../widgets/popup_menu.dart';
import '../widgets/refreshing_snackbar.dart';

class BusStopTimes extends StatefulWidget {
  final int searchNumber;
  const BusStopTimes({required this.searchNumber, super.key});

  @override
  BusStopTimesListState createState() => BusStopTimesListState();
}

class BusStopTimesListState extends State<BusStopTimes> {
  var newList = <BusListTile>[];

  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  bool use24hour = false;
  BusStopTimesListState();
  late ErrorSnackBar errorPrompt;
  late BusStop busStop;
  Icon favoriteIcon = const Icon(Icons.favorite_border_outlined);
  int busScheduleLength = 3;

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
    if (kDebugMode) {
      print("Loading bus stop times");
    }
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshStopList()); //run a start item on startup
  }

  Future<void> loadSettings() async {
    int busScheduleLength = await Config().getBusScheduleMaxResultTime();
    bool use24hour = await Config().getUse24HourTimes();
    setState(() {
      this.busScheduleLength = busScheduleLength.toInt();
      this.use24hour= use24hour;
    });
  }

  Future<void> _refreshStopList() async {
    await loadSettings();
    ScaffoldMessenger.of(context).showSnackBar(const RefreshingSnackbar());
    if (kDebugMode) {
      print("Reloading stop list");
    }
    TransitManager tm = TransitManager();
    try {
      if (kDebugMode) {
        print("getting stop information");
      }
      DateTime now = DateTime.now();
      DateTime future = now.add(Duration(hours: busScheduleLength));
      BusStopSchedules info = await tm.genStopNumbers(
          widget.searchNumber.toString(),startTime: now, endTime: future);

      newList.clear();
      if (kDebugMode) {
        print("Parsing stop information");
      }
      BusStopSchedules bss = info;
      routeName = bss.busStop.name;
      busStop = bss.busStop;
      lookupTime = DateTime.now();
      for (BusInfo bi in bss
          .schedules) { //loop over the busInfo list to parse that data

        if (kDebugMode) {
          print("adding stop item to display");
        }
        //create and add the new object to the list
        newList.add(BusListTile(bi, lookupTime, use24hour));
      }

      //unsure what this is for? something to do with updating the listview
    //
    } catch(e) {
      errorPrompt.onError(e);
    }
    setState(() {});
    if (kDebugMode) {
      print("Finished");
    }
  }

  Future<void> toggleFavorite() async {
    if (kDebugMode) {
      print("toggling favorite");
    }
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
    if (kDebugMode) {
      print("Setting icon");
    }
  }

  Future<void> loadMap() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusStopInfo(busStop: busStop)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stop #${widget.searchNumber}"),
        actions: [
          IconButton(
            onPressed: loadMap,
            icon: const Icon(Icons.map),
            tooltip: 'Map'
          ),
          IconButton(
            onPressed: toggleFavorite,
            icon: favoriteIcon,
            tooltip: 'Toggle Favorite',
          ),
          IconButton(
            onPressed: _refreshStopList,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
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
              child: newList.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No buses found at this time.",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  : ListView.builder(
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
