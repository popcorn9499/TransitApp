import 'package:flutter/material.dart';
import 'package:transit_app/api/transit_manager.dart';

import 'package:transit_app/widgets/widgets/error_snackbar.dart';


import '../../api/DataModels/bus_stop.dart';
import '../widgets/bus_stop_list_tile.dart';
import '../widgets/popup_menu.dart';
import '../widgets/refreshing_snackbar.dart';
import 'favorites_menu.dart';

class SearchStopTimes extends StatefulWidget {
  final String search;
  const SearchStopTimes({required this.search, super.key});

  @override
  SearchStopTimesListState createState() => SearchStopTimesListState();
}

class SearchStopTimesListState extends State<SearchStopTimes> {
  var newList = <BusStopListTile>[];

  String routeName = "Example";
  DateTime lookupTime = DateTime.now();
  late ErrorSnackBar errorPrompt;

  SearchStopTimesListState();


  @override
  initState() {
    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshSearchList()); //run a start item on startup
  }

  Future<void> _refreshSearchList() async {
    ScaffoldMessenger.of(context).showSnackBar(const RefreshingSnackbar());
    try {
      TransitManager tm = TransitManager();
      List<BusStop> busStops = await tm.genSearchQuery(widget.search);

      for (BusStop busStop in busStops) {
        newList.add(BusStopListTile(busStop: busStop));
      }
    } catch(e) {
      errorPrompt.onError(e);
    }
    //unsure what this is for? something to do with updating the listview
    setState(() {});

  }

  void loadFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesMenu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
        actions: [
          IconButton(
            onPressed: loadFavorites,
            icon: const Icon(Icons.favorite),
            tooltip: 'Load Favorites',
          ),
          PopupMenu(),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                _refreshSearchList();
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
