import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/DataModels/bus_info.dart';
import '../../hex_color.dart';

class BusInfoHeader extends StatelessWidget {



  final String routeName;
  final DateTime time;
  final DateFormat formatDate = DateFormat('hh:mm:ss');
  late final String stopName;
  late final String busNumber;
  late final Color busColor;
  final BusInfo busInfo;

  final double badgeColorInterpretation = 0.95;

  BusInfoHeader(
      {super.key,
        required this.routeName,
        required this.time,
        required this.busInfo
      }) {
    stopName = busInfo.getName();
    busNumber = busInfo.route.number;
    busColor = HexColor(busInfo.route.borderColor);
  }

  @override
  Widget build(BuildContext context) {
    String busNumber = this.busNumber.length >= 3
        ? this.busNumber.substring(0, 3)
        : this.busNumber;

    // Adjust color for visual clarity
    HSVColor text = HSVColor.fromColor(Theme.of(context).secondaryHeaderColor);
    HSVColor busCol = HSVColor.fromColor(busColor);
    HSVColor? col = HSVColor.lerp(text, busCol, badgeColorInterpretation) ?? busCol;

    String time = formatDate.format(this.time);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Left: Bus Number Badge + Stop Name
          Expanded(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: col.toColor(),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: col.toColor(), width: 1.0),
                  ),
                  child: Text(
                    busNumber,
                    style: TextStyle(
                      color: text.toColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    stopName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Right: Time
          Text(
            "Updated $time",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
