import 'package:flutter/material.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/TransitManager.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/bus_list_tile.dart';
import 'package:http/http.dart' as http;

import '../api/DataModels/bus_info.dart';


class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<SecondRoute> {
  var newList = <BusListTile>[];
  int? value = 0;
  @override
  initState() {
    super.initState();
  }

  void fetchUserOrder() {
    for (int i = 1; i <= 5; i++)
    {
      Future.delayed(Duration(seconds: i), () => print(i));
    }
  }
  _addItem() {
    setState(() {
      TransitManager tm = TransitManager();
      Future<BusStopSchedules> info = tm.genStopNumbers(10611);

      info.then((result){
        BusStopSchedules bss = result;
        print("GO");


        newList.add(BusListTile(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "RESEND"));

        for (BusInfo bi in bss.schedules) {
          newList.add(BusListTile(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: bi.route.toString()));
        }
        setState(() { value = 123; });
      });
      fetchUserOrder();
      newList.add(const BusListTile(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "ME"));
    });
  }

  Future<http.Response> fetchAlbum() {
    Future<http.Response>  result =  http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SecondRoute"),
      ),
      body: ListView.builder(
          itemCount: newList.length,
          itemBuilder: (context, index) => _buildRow(index)),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }


  //actually manages to return the BusListTile object for the user interface
  _buildRow(int index) {
    return newList[index];
  }
}