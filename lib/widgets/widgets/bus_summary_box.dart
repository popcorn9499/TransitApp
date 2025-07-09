import 'package:flutter/material.dart';

class BusSummaryBox extends StatelessWidget {
  final DateTime scheduled;
  final DateTime estimated;
  final int busNumber;
  final bool hasBikeRack;
  final bool hasWifi;

  const BusSummaryBox({
    super.key,
    required this.scheduled,
    required this.estimated,
    required this.busNumber,
    required this.hasBikeRack,
    required this.hasWifi,
  });

  @override
  Widget build(BuildContext context) {
    final isLate = estimated.isAfter(scheduled);
    final isEarly = estimated.isBefore(scheduled);

    final scheduledStr = TimeOfDay.fromDateTime(scheduled).format(context);
    final estimatedStr = TimeOfDay.fromDateTime(estimated).format(context);

    final Color estimatedColor = isLate
        ? Colors.redAccent
        : isEarly
        ? Colors.orangeAccent
        : Colors.greenAccent;

    const labelStyle = TextStyle(color: Colors.white70, fontSize: 14);
    const valueStyle = TextStyle(color: Colors.white, fontSize: 14);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Bus number on its own row
          Row(
            children: [
              const Icon(Icons.directions_bus, color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Text('Bus #$busNumber', style: valueStyle),
            ],
          ),

          const SizedBox(height: 6),

          /// Bike Rack and Wi-Fi on a row below
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_bike, color: Colors.white70, size: 18),
                  const SizedBox(width: 4),
                  Text('Bike Rack: ', style: labelStyle),
                  Text(hasBikeRack ? 'Yes' : 'No', style: valueStyle),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.wifi, color: Colors.white70, size: 18),
                  const SizedBox(width: 4),
                  Text('Wi-Fi: ', style: labelStyle),
                  Text(hasWifi ? 'Yes' : 'No', style: valueStyle),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Departure times
          const Text(
            'Departure Times',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Scheduled:', style: labelStyle),
              Text(scheduledStr, style: valueStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Estimated:', style: labelStyle),
              Text(
                estimatedStr,
                style: valueStyle.copyWith(
                  color: estimatedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
