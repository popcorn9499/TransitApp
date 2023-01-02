import 'package:flutter/material.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/widgets/bus_list_tile.dart';
import 'package:http/http.dart' as http;

import '../../api/DataModels/bus_info.dart';
import '../../api/DataModels/bus_stop.dart';
import '../widgets/layout_stop_times_header.dart';

class SearchStopTimes extends StatefulWidget {
  final String search;
  const SearchStopTimes({required this.search, Key? key}) : super(key: key);

  @override
  SearchStopTimesListState createState() => SearchStopTimesListState(search: search);
}

class SearchStopTimesListState extends State<SearchStopTimes> {
  var newList = <BusListTile>[];
  final String search;
  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  SearchStopTimesListState({required this.search});

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshSearchList()); //run a start item on startup
  }

  _refreshSearchList() {
    final snackBar = SnackBar(
      content: const Text('Reloading bus schedule'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    TransitManager tm = TransitManager();
    Future<List<BusStop>> busStops = tm.genSearchQuery(search);

    busStops.then((result) {

      //unsure what this is for? something to do with updating the listview
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
        actions: [
          FloatingActionButton(
              onPressed: _refreshSearchList, child: const Icon(Icons.favorite_border_outlined)),
          FloatingActionButton(
              onPressed: _refreshSearchList, child: const Icon(Icons.refresh)),
          FloatingActionButton(
              onPressed: _refreshSearchList, child: const Icon(Icons.menu)),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              setState(() {
                _refreshSearchList();
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
