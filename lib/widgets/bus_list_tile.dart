import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";

class BusListTile extends StatelessWidget {
  const BusListTile(
      {Key? key,
      required this.timeRemaining,
      required this.busStatus,
      required this.stopName})
      : super(key: key);
  final String timeRemaining;
  final BusStatus busStatus;
  final String stopName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Colors.blue,
            ),
            child: Text("HI"),
          ),
          Expanded(
            flex: 6,
            child: Text(stopName, textAlign: TextAlign.left),
          ),
          Expanded(
            flex: 1,
            child: Text(busStatus.toShortString(), textAlign: TextAlign.right),
          ),
          Expanded(
            flex: 1,
            child: Text(timeRemaining, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
