import 'package:flutter/material.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/widgets/bus_list_tile.dart';
import 'package:http/http.dart' as http;

import '../../api/DataModels/bus_info.dart';
import '../widgets/layout_stop_times_header.dart';

class BusStopTimes extends StatefulWidget {
  final String searchNumber;
  const BusStopTimes({required this.searchNumber, Key? key}) : super(key: key);

  @override
  BusStopTimesListState createState() => BusStopTimesListState(searchNumber: searchNumber);
}

class BusStopTimesListState extends State<BusStopTimes> {
  var newList = <BusListTile>[];
  final String searchNumber;
  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  BusStopTimesListState({required this.searchNumber});

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshStopList()); //run a start item on startup
  }

  _refreshStopList() {
    const snackBar = SnackBar(
      content: Text('Reloading bus schedule'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

      TransitManager tm = TransitManager();
      Future<BusStopSchedules> info = tm.genStopNumbers(searchNumber);

      info.then((result) {
        newList.clear();
        BusStopSchedules bss = result;
        routeName = bss.busStop.name;
        lookupTime = DateTime.now();;
        for (BusInfo bi in bss.schedules) {
          int remaining = bi.arrivalEstimated.difference(lookupTime).inMinutes;
          newList.add(BusListTile(
              timeRemaining: "$remaining Min",
              busStatus: bi.getOnTime(),
              stopName: bi.route.name,
              busColor: const Color.fromARGB(255, 0, 114, 178),
              busNumber: bi.route.number.toString()));
        }
        //unsure what this is for? something to do with updating the listview
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stop $searchNumber"),
        actions: [
          FloatingActionButton(
              onPressed: _refreshStopList, child: const Icon(Icons.favorite_border_outlined)),
          FloatingActionButton(
              onPressed: _refreshStopList, child: const Icon(Icons.refresh)),
          FloatingActionButton(
              onPressed: _refreshStopList, child: const Icon(Icons.menu)),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
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
