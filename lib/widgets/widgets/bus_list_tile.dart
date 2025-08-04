import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/hex_color.dart';
import 'package:transit_app/widgets/menus/bus_info_menu.dart';

import '../../api/DataModels/bus_info.dart';

class BusListTile extends StatelessWidget {
  BusListTile(this.busInfo, DateTime lookupTime, bool use24hour,
      {super.key}) {
    int remaining = busInfo.arrivalEstimated
        .difference(lookupTime)
        .inMinutes;
    if (remaining <= 60) {
      timeRemaining = "$remaining min";
    } else {
      if (use24hour) {
        timeRemaining =
        "${busInfo.arrivalEstimated.hour.toString().padLeft(2, '0')}:${busInfo
            .arrivalEstimated.minute.toString().padLeft(2, '0')}";
      } else {
        timeRemaining =
        "${(busInfo.arrivalEstimated.hour % 12).toString().padLeft(
            2, '0').replaceAll("00", "12").replaceAll(RegExp(r'^0+(?=.)'), '')}:${busInfo.arrivalEstimated
            .minute.toString().padLeft(2, '0')} ${["AM", "PM"][busInfo.arrivalEstimated.hour >= 12 ? 1 : 0]}";
      }
    }
    busStatus = busInfo.getOnTime();
    stopName = busInfo.getName();
    busNumber = busInfo.route.number;
    busColor = HexColor(busInfo.route.borderColor);
  }

  BusInfo busInfo;
  late String timeRemaining;
  late BusStatus busStatus;
  late String stopName;
  late String busNumber;
  late Color busColor;
  final double badgeColorInterpretation = 0.95;


  @override
  Widget build(BuildContext context) {
    String busNumber = this.busNumber;
    if (this.busNumber.length >= 3 && this.busNumber.toString() != "BLUE") {
      busNumber = busNumber.substring(0,3);
    }

    //adjust the color to make the bus badge colors slightly nicer for viewing
    HSVColor text = HSVColor.fromColor(Theme.of(context).secondaryHeaderColor);
    HSVColor busCol = HSVColor.fromColor(busColor);
    HSVColor? col = HSVColor.lerp(text, busCol, badgeColorInterpretation);
    col ??= HSVColor.fromColor(busColor);

    return ListTile(
      onTap: () { Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BusInfoMenu(busInfo: busInfo)),
      );},
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 45, //this should not be static
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(3.0),
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
            child: Text(stopName, textAlign: TextAlign.left, style: TextStyle(fontSize: 14.5)),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(busInfo.bikeRack ? Icons.pedal_bike : null, size: 20),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(busInfo.isDualBus ? Icons.filter_2 : null, size: 20),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(busStatus.toShortString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 2,
            child: Text(timeRemaining, textAlign: TextAlign.right, style: TextStyle(fontSize: 14, wordSpacing: 0.05, letterSpacing: 0.5)),
          ),
        ],
      ),
    );
  }
}
