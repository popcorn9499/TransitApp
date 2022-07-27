import 'package:flutter/material.dart';
import "package:transit_app/BusStatus.dart";
import "package:transit_app/BusListTile.dart";

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

  _buildRow(int index) {
    return newList[index];
  }
}