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

class SearchStopTimes extends StatefulWidget {
  final String search;
  final FavoriteManager fm;
  const SearchStopTimes({required this.search, required this.fm, Key? key}) : super(key: key);

  @override
  SearchStopTimesListState createState() => SearchStopTimesListState();
}

class SearchStopTimesListState extends State<SearchStopTimes> {
  var newList = <BusStopListTile>[];

  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  late ErrorSnackBar errorPrompt;

  SearchStopTimesListState();


  @override
  initState() {
    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshSearchList()); //run a start item on startup
  }

  _refreshSearchList() {
    const snackBar = SnackBar(
      content: Text('Reloading bus schedule'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    TransitManager tm = TransitManager();
    Future<List<BusStop>> busStops = tm.genSearchQuery(widget.search);
    String stopName;
    int stopNumber;

    busStops.then((result) { //asyncly parse the object recieved and store data required
      for (BusStop busStop in result) {
        stopName = busStop.name;
        stopNumber = busStop.number;
        newList.add(BusStopListTile(stopName: stopName, stopNumber: stopNumber, fm: widget.fm));
      }
      //unsure what this is for? something to do with updating the listview
      setState(() {});
    }).catchError(errorPrompt.onError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
        actions: [
          FloatingActionButton(
              onPressed: _refreshSearchList, child: const Icon(Icons.favorite)),
          FloatingActionButton(
              onPressed: _refreshSearchList, child: const Icon(Icons.menu)),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                _refreshSearchList();
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
