import 'package:flutter/material.dart';

import '../../api/DataModels/bus_stop.dart';
import '../menus/bus_stop_times.dart';

class BusStopListTile extends StatelessWidget {
  BusStopListTile(
      {super.key,
        required this.busStop,
      }) {
      stopName = busStop.name;
      stopNumber = busStop.number;
  }
  final BusStop busStop;
  late String stopName;
  late int stopNumber;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusStopTimes(searchNumber: stopNumber)),
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
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(3),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                stopName,
                style: const TextStyle(
                  fontSize: 22,
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
