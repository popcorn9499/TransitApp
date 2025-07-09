import 'package:flutter/material.dart';

class DepartureInfoBox extends StatelessWidget {
  final DateTime scheduled;
  final DateTime estimated;
  final int busNumber;
  final bool hasBikeRack;
  final bool hasWifi;

  const DepartureInfoBox({
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
          /// Header Row: Bus number + Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bus #$busNumber',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (hasBikeRack)
                    const Icon(Icons.directions_bike, color: Colors.white70, size: 20),
                  if (hasWifi)
                    const Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Icon(Icons.wifi, color: Colors.white70, size: 20),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Departure Info
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
              const Text(
                'Scheduled:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                scheduledStr,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estimated:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                estimatedStr,
                style: TextStyle(
                  color: estimatedColor,
                  fontSize: 14,
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
