import 'package:flutter/material.dart';
import "package:transit_app/BusStatus.dart";
import "package:transit_app/BusListTile.dart";

class SecondRoute extends StatefulWidget {
  SecondRoute({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<SecondRoute> {
  var newList = <BusListItem>[];

  _addItem() {
    setState(() {
      newList.add(BusListItem(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "ME"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondRoute"),
      ),
      body: ListView.builder(
          itemCount: this.newList.length,
          itemBuilder: (context, index) => this._buildRow(index)),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  _buildRow(int index) {
    return newList[index];
  }
}