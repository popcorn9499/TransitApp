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
    stopName = busInfo.getName();
    busNumber = busInfo.route.number;
    busColor = HexColor(busInfo.route.borderColor);
  }


  late String timeRemaining;
  late BusStatus busStatus;
  late String stopName;
  late String busNumber;
  late Color busColor;
  final badgeColorInterpretation = 0.02;


  @override
  Widget build(BuildContext context) {
    String busNumber = this.busNumber;
    if (this.busNumber.length >= 3) {
      busNumber = busNumber.substring(0,3);
    }

    //adjust the color to make the bus badge colors slightly nicer for viewing
    HSVColor text = HSVColor.fromColor(Theme.of(context).secondaryHeaderColor);
    HSVColor busCol = HSVColor.fromColor(busColor);
    HSVColor? col = HSVColor.lerp(busCol, text, badgeColorInterpretation);
    col ??= HSVColor.fromColor(busColor);

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
              border: Border.all(color: col.toColor()),
              color: col.toColor(),
            ),
            child: Center(child: RichText(text: TextSpan(text: busNumber, style: TextStyle(
              color: text.toColor(),
            )))),
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
