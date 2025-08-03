import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transit_app/Config/dark_theme_preference.dart';
import 'package:transit_app/widgets/menus/main_menu.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../Config/config.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  SettingsMenuState createState() => SettingsMenuState();
}

//TODO fix my stupidity. I think i must of really loved enumerators!
enum Times {
  one(1), two(2), three(3), four(4), six(6), eight(8),
  twelve(12), sixteen(16), twentyFour(24), thirty(30);

  final int hours;
  const Times(this.hours);

  String valueOf() => hours.toString();
}


class SettingsMenuState extends State<SettingsMenu> {
  late ErrorSnackBar errorPrompt;
  bool darkMode = false;
  double nearbyStopsDist = 0.5;
  int busScheduleMaxResultTime = 2;
  bool use24Hour = false;
  final ValueNotifier<Times> _selectedItem = ValueNotifier<Times>(Times.two);

  @override
  initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>
        loadSettings()); //run a start item on startup


    super.initState();
    errorPrompt = ErrorSnackBar(context: context);
  }


  Future<void> loadSettings() async {
    bool darkValue = await DarkThemePreference().getTheme();
    double nearbyStopsDistance = await Config().getNearbyStopDist();
    int maxScheduleTime = await Config().getBusScheduleMaxResultTime();
    bool using24Hourtime = await Config().getUse24HourTimes();

    setState(() {
      darkMode = darkValue;
      nearbyStopsDist = nearbyStopsDistance;
      busScheduleMaxResultTime = maxScheduleTime;
      _selectedItem.value = Times.values.firstWhere(
            (t) => t.hours == maxScheduleTime,
        orElse: () => Times.two,
      );
      use24Hour = using24Hourtime;
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
                            isLightTheme.add(
                                value ? ThemeMode.dark : ThemeMode.light);
                            setState(() {
                              darkMode = value;
                            });
                          })),
                  const _CustomListTile(
                      title: "Notifications",
                      icon: Icons.notifications_none_rounded),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Nearby stops distance $nearbyStopsDist meters",
                        border: const OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (String value) {
                      setState() {
                        nearbyStopsDist = double.parse(value);
                        Config().setNearbyStopDist(nearbyStopsDist);
                      }
                    },
                    onSubmitted: (String value) {
                      double doub = double.parse(value);
                      Config().setNearbyStopDist(doub);
                      setState() {
                        nearbyStopsDist = doub;
                      }
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        "Bus schedule results interval: ${_selectedItem.value.valueOf()} hrs",
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        showMenu<Times>(
                          context: context,
                          position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                          items: Times.values.map((time) {
                            return PopupMenuItem<Times>(
                              value: time,
                              child: AnimatedBuilder(
                                animation: _selectedItem,
                                builder: (context, _) {
                                  return RadioListTile<Times>(
                                    value: time,
                                    groupValue: _selectedItem.value,
                                    title: Text("${time.valueOf()} Hours"),
                                    onChanged: (Times? value) {
                                      if (value != null) {
                                        _selectedItem.value = value;
                                        Config().setBusScheduleMaxResultTime(value.hours);
                                        Navigator.pop(context);
                                        setState(() {});
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  )

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
      {required this.title, required this.icon, this.trailing});

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
    this.title,
    required this.children,
  });

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

