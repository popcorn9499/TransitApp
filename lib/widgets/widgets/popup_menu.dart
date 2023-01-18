import 'package:flutter/material.dart';

import '../menus/settings_menu.dart';


// This is the type used by the popup menu below.
enum SampleItem { settings, itemTwo, itemThree }


class PopupMenu extends StatelessWidget {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          value: SampleItem.settings,
          child: const Text('Settings'),
          onTap: () {
            print("HELLO");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsMenu()),
            );
          },
        )
      ],
    );
  }
}