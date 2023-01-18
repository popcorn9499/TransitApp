
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black12,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.white),
      secondaryHeaderColor: Colors.black
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
      secondaryHeaderColor: Colors.black,
    );
  }
}
