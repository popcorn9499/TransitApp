import 'package:flutter/material.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../api/DataModels/bus_info.dart';
import '../widgets/bus_stop_list_tile.dart';
import '../widgets/popup_menu.dart';

class BusInfoMenu extends StatefulWidget {
  final BusInfo busInfo;
  const BusInfoMenu({super.key, required this.busInfo});

  @override
  BusInfoMenuState createState() => BusInfoMenuState();
}

class BusInfoMenuState extends State<BusInfoMenu> {
  var newList = <BusStopListTile>[];
  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  late ErrorSnackBar errorPrompt;

  BusInfoMenuState();


  @override
  initState() {
    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => loadFavoritesList()); //run a start item on startup
  }


  @override
  Widget build(BuildContext context) {
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
