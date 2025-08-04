import 'package:flutter/material.dart';
import 'package:transit_app/widgets/widgets/bus_info_header.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../api/DataModels/bus_info.dart';
import '../../api/DataModels/bus_stop.dart';
import '../../bus_status.dart';
import '../../hex_color.dart';
import '../widgets/bus_stop_list_tile.dart';
import '../widgets/bus_summary_box.dart';
import '../widgets/popup_menu.dart';

class BusStopInfo extends StatefulWidget {
  final BusStop busStop;

  const BusStopInfo({super.key, required this.busStop});

  @override
  BusStopInfoState createState() => BusStopInfoState();
}

class BusStopInfoState extends State<BusStopInfo> {
  var newList = <BusStopListTile>[];
  late ErrorSnackBar errorPrompt;

  late String timeRemaining;

  final double badgeColorInterpretation = 0.95;

  BusStopInfoState();


  @override
  initState() {
    super.initState();
    timeRemaining = "0 minutes";

    errorPrompt = ErrorSnackBar(context: context);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => loadFavoritesList()); //run a start item on startup
  }


  @override
  Widget build(BuildContext context) {
    String stopNumber = widget.busStop.number.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Stop #$stopNumber Information"),
        actions: [
          PopupMenu(),
        ],
      ),
      body: Column(children: <Widget>[

          ])
    );
  }

  //actually manages to return the BusListTile object for the user interface
  _buildRow(int index) {

  }
}
