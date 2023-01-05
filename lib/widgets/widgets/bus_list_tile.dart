import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/hex_color.dart';

import '../../api/DataModels/bus_info.dart';

class BusListTile extends StatelessWidget {
  BusListTile(BusInfo busInfo, DateTime lookupTime,
      {Key? key})
      : super(key: key) {
    int remaining = busInfo.arrivalEstimated
        .difference(lookupTime)
        .inMinutes;
    timeRemaining = "$remaining Min";
    busStatus = busInfo.getOnTime();
    stopName = busInfo.route.name;
    busNumber = busInfo.route.number.toString();
    busColor = HexColor(busInfo.route.borderColor);
  }


  late String timeRemaining;
  late BusStatus busStatus;
  late String stopName;
  late String busNumber;
  late Color busColor;



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
