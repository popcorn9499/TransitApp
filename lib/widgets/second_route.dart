import 'package:flutter/material.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/bus_list_tile.dart';
import 'package:http/http.dart' as http;

import '../api/DataModels/bus_info.dart';

class SecondRoute extends StatefulWidget {
  final String searchNumber;
  const SecondRoute({required this.searchNumber, Key? key}) : super(key: key);

  @override
  MyListState createState() => MyListState(searchNumber: searchNumber);
}

class MyListState extends State<SecondRoute> {
  var newList = <BusListTile>[];
  int? value = 0;
  final String searchNumber;
  String routeName = "Example";
  MyListState({required this.searchNumber});

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshStopList()); //run a start item on startup
  }

  _refreshStopList() {
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

    setState(() {
      TransitManager tm = TransitManager();
      Future<BusStopSchedules> info = tm.genStopNumbers(searchNumber);

      info.then((result) {
        newList.clear();
        BusStopSchedules bss = result;
        routeName = bss.busStop.name;
        DateTime currentTime = DateTime.now();
        for (BusInfo bi in bss.schedules) {
          int remaining = bi.arrivalEstimated.difference(currentTime).inMinutes;
          newList.add(BusListTile(
              timeRemaining: "$remaining Min",
              busStatus: bi.getOnTime(),
              stopName: bi.route.name,
              busColor: const Color.fromARGB(255, 0, 114, 178),
              busNumber: bi.route.number.toString()));
        }
        setState(() {
          value = 123;
        });
      });
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
            Container(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    routeName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
