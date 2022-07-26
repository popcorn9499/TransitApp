import 'package:flutter/material.dart';
import "package:transit_app/BusStatus.dart";
import "package:transit_app/BusListTile.dart";

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            const ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
            ),
            const ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
              dense: true,
            ),
            BusListItemData(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "WHY"),
            BusListItemData(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "WHY"),
            BusListItemData(timeRemaining: "1 Min", busStatus: BusStatus.Late, stopName: "KP Louelda AT 123 hi my life 1000000 1000"),
          ],
        ),
      ),
    );
  }
}