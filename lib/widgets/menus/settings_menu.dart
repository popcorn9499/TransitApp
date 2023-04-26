
import 'package:flutter/material.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    _CustomListTile(
                        title: "Dark Mode",
                        icon: Icons.dark_mode_outlined,
                        trailing: Switch(
                            value: darkMode,
                            onChanged: (value) {
                              DarkThemePreference().setDarkTheme(value);
                              isLightTheme.add(value ? ThemeMode.dark : ThemeMode.light);
                              setState(() {
                                darkMode = value;
                              });
                            })),
                    const _CustomListTile(
                        title: "Notifications",
                        icon: Icons.notifications_none_rounded),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}

