import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transit_app/Config/DarkThemePreference.dart';
import 'package:transit_app/widgets/menus/main_menu.dart';
import 'package:transit_app/widgets/widgets/error_snackbar.dart';

import '../../Config/Config.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  SettingsMenuState createState() => SettingsMenuState();
}

enum Times {
  one,
  two,
  three,
  four,
  six,
  eight,
  twelve,
  sixteen,
  twentyFour,
  thirty;


  String valueOf() {
    String result = "N/A";
    switch(index) {
      case 0:
        result = "1";
        break;
      case 1:
        result = "2";
        break;
      case 2:
        result = "3";
        break;
      case 3:
        result = "4";
        break;
      case 4:
        result = "6";
        break;
      case 5:
        result = "8";
        break;
      case 6:
        result = "12";
        break;
      case 7:
        result = "16";
        break;
      case 8:
        result = "24";
        break;
      case 9:
        result = "30";
        break;
    }
    return result;
  }
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
    bool darkValue = false;


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
                        labelText: "Nearby stops distance ${nearbyStopsDist}km",
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
                        style: const TextStyle(color: Colors.white), // 👈 sets text color),
                      ),
                    onPressed: () {
                      showMenu<Times>(
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                        items: List.generate(Times.values.length, (index) {
                          return PopupMenuItem<Times>(
                            value: Times.values[index],
                            child: AnimatedBuilder(
                              animation: _selectedItem,
                              builder: (context, child) {
                                return RadioListTile<Times>(
                                  value: Times.values[index],
                                  groupValue: _selectedItem.value,
                                  title: child,
                                  onChanged: (Times? value) {
                                    if (value != null) {
                                      _selectedItem.value = value;
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              },
                              child: Text("${Times.values[index].valueOf()} Hours"),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  ),
                  Tooltip(
                      message: "Bus Schedule Results Times",
                      child: TextButton.icon(
                        icon: const Icon(Icons.color_lens),
                        label: const Text("Color"),
                        onPressed: () {
                          showMenu(
                              context: context,
                              position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                              items: List.generate(Times.values.length, (index) {
                                return PopupMenuItem(
                                  value: Times.values[index],
                                  child: AnimatedBuilder(

                                    animation: _selectedItem,
                                    builder: (BuildContext context, Widget? child) {
                                      return RadioListTile<Times>(
                                        value: Times.values[index],
                                        groupValue: _selectedItem.value,
                                        title: child,
                                        onChanged: (Times? value) {
                                          if (value != null) {
                                            _selectedItem.value = value;
                                          }
                                        },
                                      );

                                    },
                                    child: Text("${Times.values[index].valueOf()} Hours"),
                                  ),

                                );
                              })
                          );

                        },
                      )
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

