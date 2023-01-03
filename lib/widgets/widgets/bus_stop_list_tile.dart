import 'package:flutter/material.dart';
import 'package:transit_app/Config/favorite_manager.dart';
import "package:transit_app/bus_status.dart";

import '../menus/bus_stop_times.dart';

class BusStopListTile extends StatelessWidget {
  const BusStopListTile(
      {Key? key,
        required this.stopName,
        required this.stopNumber,
        required this.fm
      })
      : super(key: key);

  final FavoriteManager fm;
  final String stopName;
  final int stopNumber;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusStopTimes(searchNumber: stopNumber, fm: fm)),
        );
      },
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                stopName,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                stopNumber.toString(),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
