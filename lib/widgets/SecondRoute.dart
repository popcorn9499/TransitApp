import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/widgets/BusListTile.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<SecondRoute> {
  var newList = <BusListTile>[];

  _addItem() {
    setState(() {
      newList.add(const BusListTile(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "ME"));
    });
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