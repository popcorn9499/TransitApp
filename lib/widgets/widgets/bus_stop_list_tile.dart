import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";

class BusStopListTile extends StatelessWidget {
  const BusStopListTile(
      {Key? key,
        required this.stopName,
        required this.stopNumber
      })
      : super(key: key);


  final String stopName;
  final String stopNumber;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () { print("COOL");},
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
                stopNumber,
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
