import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LayoutStopTimesHeader extends StatelessWidget {


  final bool use24Hour;
  final String routeName;
  final DateTime? time;

  const LayoutStopTimesHeader(
      {super.key,
        required this.routeName,
        this.time,
        this.use24Hour = false
      });

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = use24Hour ? DateFormat('HH:mm:ss') : DateFormat('h:mm:ss a');
    String formattedTime = "";
    if (time != null) {
      formattedTime = formatDate.format(time!);
    }
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              routeName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          if (formattedTime.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Updated $formattedTime",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
