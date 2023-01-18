import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum SampleItem { settings, itemTwo, itemThree }


class PopupMenu extends StatelessWidget {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.settings,
          child: Text('Settings'),
        )
      ],
    );
  }
}