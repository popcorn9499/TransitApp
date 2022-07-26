import 'package:flutter/material.dart';
import "package:transit_app/BusStatus.dart";

class BusListItemData extends StatelessWidget {
  BusListItemData(
      {Key? key,
      required this.timeRemaining,
      required this.busStatus,
      required this.stopName})
      : super(key: key);
  String timeRemaining;
  BusStatus busStatus;
  String stopName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.map),
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
