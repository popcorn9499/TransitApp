import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:transit_app/Config/DarkThemePreference.dart';
import 'package:transit_app/widgets/menus/main_menu.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../widgets/popup_menu.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  SettingsMenuState createState() => SettingsMenuState();
}

class SettingsMenuState extends State<SettingsMenu> {
  late ErrorSnackBar errorPrompt;
  bool darkMode = false;


  SettingsMenuState();


  @override
  initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadSettings()); //run a start item on startup
    bool darkValue = false;


    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
  }


  Future<void> loadSettings() async {
    bool darkValue = await DarkThemePreference().getTheme();
    setState(() {
      darkMode = darkValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Setting Used $darkMode");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          PopupMenu(),
        ],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  DarkThemePreference().setDarkTheme(value);
                  isLightTheme.add(value ? ThemeMode.dark : ThemeMode.light);
                  setState(() {
                    darkMode = value;
                  });
                },
                initialValue: darkMode,
                leading: Icon(Icons.format_paint),
                title: Text('Enable Dark Mode'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
