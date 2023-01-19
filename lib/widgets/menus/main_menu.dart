import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transit_app/api/TransitManager.dart';
import 'dart:math';
import 'package:transit_app/widgets/menus/bus_stop_times.dart';
import 'package:transit_app/widgets/menus/search_bus_stops.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../Config/favorite_manager.dart';
import '../../api/DataModels/bus_stop.dart';
import '../../api/Exceptions/NetworkError.dart';
import '../styles/Style.dart';
import '../widgets/popup_menu.dart';
import 'close_stops_menu.dart';
import 'favorites_menu.dart';


class MainMenu extends StatelessWidget {

  MainMenu({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode mode = ThemeMode.dark;
    return MaterialApp(
      title: 'Transit App',
      theme: Styles.lightTheme( context),
      darkTheme: Styles.darkTheme(context),
      themeMode: mode,
      home: const MyHomePage(title: 'Transit App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  late ErrorSnackBar errorPrompt;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    errorPrompt = ErrorSnackBar(context: context);
  }

  void loadFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesMenu()),
    );
  }

  void loadCloseStops() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CloseStopsMenu()),
    );
  }

  void loadBusRoutes() {
    TransitManager tm = TransitManager();
      Future<List<BusStop>> busStops =  tm.genSearchQuery(_controller.text);
      busStops.then((result) {
        if (result.length == 1) { //handle just looking based on the text
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BusStopTimes(searchNumber: result[0].number)),
          );
        } else {
          //load up another view for selecting from multiple
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchStopTimes(search: _controller.text)),
          );
        }
      }).catchError(errorPrompt.onError);

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          FloatingActionButton(
          onPressed: loadCloseStops, child: const Icon(Icons.location_pin)),
          FloatingActionButton(
              onPressed: loadFavorites, child: const Icon(Icons.favorite)),
          PopupMenu(),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          children: <Widget>[
            TextField(
              controller: _controller,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search by Street name, Route Number or Stop Number",
                ),
              onSubmitted: (String value) async {
                loadBusRoutes();
              }
            ),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                // Navigate to second route when tapped.
                loadBusRoutes();
              },
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}