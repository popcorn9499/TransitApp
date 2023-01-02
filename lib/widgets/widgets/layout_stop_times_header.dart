import 'package:flutter/material.dart';
import "package:transit_app/bus_status.dart";

class LayoutStopTimesHeader extends StatelessWidget {
  const LayoutStopTimesHeader(
      {Key? key,
        required this.routeName,
      })
      : super(key: key);


  final String routeName;




  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            routeName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
