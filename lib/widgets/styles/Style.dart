
import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black12,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        actionsIconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.white),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
    );
  }
}
