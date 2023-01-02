import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";

class BusListTile extends StatelessWidget {
  const BusListTile(
      {Key? key,
      required this.timeRemaining,
      required this.busStatus,
      required this.stopName,
      required this.busNumber,
      required this.busColor,
      })
      : super(key: key);


  final String timeRemaining;
  final BusStatus busStatus;
  final String stopName;
  final String busNumber;
  final Color busColor;



  @override
  Widget build(BuildContext context) {
    String busNumber = this.busNumber;
    if (this.busNumber.length >= 3) {
      busNumber = busNumber.substring(0,3);
    }



    return ListTile(
      onTap: () { print("COOL");},
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 45, //this should not be static
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: busColor),
              color: busColor,
            ),
            child: Center(child: Text(busNumber)),
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
