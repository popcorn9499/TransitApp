import 'dart:async';


import 'package:flutter/material.dart';

//try to create something that can be fired when an
// error occurs that gives a standard prompt
class RefreshingSnackbar extends SnackBar {
  const RefreshingSnackbar({super.key}) : super(content: const Text("Refreshing"));
}