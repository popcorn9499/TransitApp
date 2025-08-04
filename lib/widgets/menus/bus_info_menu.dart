import 'package:flutter/material.dart';
import 'package:transit_app/widgets/widgets/bus_info_header.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../Config/config.dart';
import '../../api/DataModels/bus_info.dart';
import '../../bus_status.dart';
import '../../hex_color.dart';
import '../widgets/bus_stop_list_tile.dart';
import '../widgets/bus_summary_box.dart';
import '../widgets/popup_menu.dart';

class BusInfoMenu extends StatefulWidget {
  final BusInfo busInfo;

  const BusInfoMenu({super.key, required this.busInfo});

  @override
  BusInfoMenuState createState() => BusInfoMenuState();
}

class BusInfoMenuState extends State<BusInfoMenu> {
  var newList = <BusStopListTile>[];
  late ErrorSnackBar errorPrompt;

  late String timeRemaining;
  late BusStatus busStatus;
  late String stopName;
  late String busNumber;
  late Color busColor;
  final double badgeColorInterpretation = 0.95;
  bool use24Hour = false;

  BusInfoMenuState();


  @override
  initState() {
    super.initState();
    timeRemaining = "0 minutes";
    busStatus = widget.busInfo.getOnTime();
    stopName = widget.busInfo.getName();
    busNumber = widget.busInfo.route.number;
    busColor = HexColor(widget.busInfo.route.borderColor);
    errorPrompt = ErrorSnackBar(context: context);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => loadFavoritesList()); //run a start item on startup


    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadSettings()); //run a start item on startup
  }

Future<void> loadSettings() async {
  bool use24Hour = await Config().getUse24HourTimes();
  setState(() {
    this.use24Hour = use24Hour;
  });
}

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


    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Information"),
        actions: [
          PopupMenu(),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {

              });
            });
          },
          child: Column(children: <Widget>[
            BusInfoHeader(routeName: widget.busInfo.stop.name, time: DateTime.now(), busInfo: widget.busInfo, use24Hour: use24Hour,),
          BusSummaryBox(
            scheduled: widget.busInfo.departureScheduled,
            estimated: widget.busInfo.departureEstimated,
            busNumber: widget.busInfo.busNumber,
            hasBikeRack: widget.busInfo.bikeRack,
            hasWifi: widget.busInfo.wifi,
            isDualBus: widget.busInfo.isDualBus,
            use24Hour: use24Hour,
          )
          ,
            Expanded(
              child: ListView.builder(
                itemCount: newList.length,
                itemBuilder: (context, index) => _buildRow(index),
              ),
            ),
          ])),
    );
  }

  //actually manages to return the BusListTile object for the user interface
  _buildRow(int index) {
    return newList[index];
  }
}
