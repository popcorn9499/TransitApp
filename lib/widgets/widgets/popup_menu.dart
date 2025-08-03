import 'package:flutter/material.dart';

import '../menus/settings_menu.dart';


// This is the type used by the popup menu below.
enum SampleItem { settings, itemTwo, itemThree }


class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      icon: const Icon(Icons.menu),
      onSelected: (result) {
        if (result == SampleItem.settings) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsMenu()),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.settings,
          child: Text('Settings'),
        )
      ],
    );
  }
}