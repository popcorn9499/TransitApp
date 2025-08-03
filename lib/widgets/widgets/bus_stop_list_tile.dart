import 'package:flutter/material.dart';

import '../../api/DataModels/bus_stop.dart';
import '../menus/bus_stop_times.dart';

class BusStopListTile extends StatelessWidget {
  const BusStopListTile(
      {super.key,
        required this.busStop,
      });
  final BusStop busStop;


  @override
  Widget build(BuildContext context) {
    final String stopName = busStop.name;
    final int stopNumber = busStop.number;
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
