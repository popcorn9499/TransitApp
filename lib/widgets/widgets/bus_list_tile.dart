import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";
import 'package:transit_app/hex_color.dart';
import 'package:transit_app/widgets/menus/bus_info_menu.dart';

import '../../Config/config.dart';
import '../../api/DataModels/bus_info.dart';

class BusListTile extends StatefulWidget {
  final dynamic busInfo;
  final DateTime lookupTime;

  const BusListTile(this.busInfo, this.lookupTime, {super.key});


  @override
  BusListTileState createState() => BusListTileState();
}

class BusListTileState extends State<BusListTile> {
  int remaining = 0;
  bool use24Hour = false;
  String timeRemaining = "";
  late BusStatus busStatus;

  late String stopName;
  late String busNumber;
  late HexColor busColor;

  BusListTileState();

  @override
  initState() {
    super.initState();
    remaining = widget.busInfo.arrivalEstimated
          .difference(widget.lookupTime)
          .inMinutes;
    WidgetsBinding.instance
          .addPostFrameCallback((_) => load24HourClock());
    if (remaining <= 60) {
      timeRemaining = "$remaining min";
    } else if (use24Hour) {
      timeRemaining = "${widget.busInfo.arrivalEstimated.hour}:${widget.busInfo.arrivalEstimated.minute.toString().padLeft(2, '0')}";
    } else {
      timeRemaining = "${(widget.busInfo.arrivalEstimated.hour % 12).toString().padLeft(2, '0').replaceAll("00", "12")}:${widget.busInfo.arrivalEstimated.minute.toString().padLeft(2, '0')} ${["AM", "PM"][widget.busInfo.arrivalEstimated.hour >= 12]}";
    }
    busStatus = widget.busInfo.getOnTime();
    stopName = widget.busInfo.getName();
    busNumber = widget.busInfo.route.number;
    busColor = HexColor(widget.busInfo.route.borderColor);
  }

  Future<void> load24HourClock() async {
    bool use24Hour = await Config().getUse24HourTimes();

    setState(() {
      this.use24Hour = use24Hour;
    });
  }

  final double badgeColorInterpretation = 0.95;


  @override
  Widget build(BuildContext context) {
    String busNumber = this.busNumber;
    if (this.busNumber.length >= 3) {
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
        MaterialPageRoute(builder: (context) => BusInfoMenu(busInfo: widget.busInfo)),
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
            child: Text(stopName, textAlign: TextAlign.left),
          ),
          Expanded(
            flex: 2,
            child: Text(busStatus.toShortString(), textAlign: TextAlign.right, style: TextStyle(fontSize: 15)),
          ),
          Expanded(
            flex: 2,
            child: Text(timeRemaining, textAlign: TextAlign.right, style: TextStyle(wordSpacing: 0.05, letterSpacing: 0.5),),
          ),
        ],
      ),
    );
  }
}
