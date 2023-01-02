import 'dart:async';


import 'package:flutter/material.dart';

//try to create something that can be fired when an
// error occurs that gives a standard prompt
class ErrorSnackBar {
  BuildContext context;
  ErrorSnackBar({required this.context});

  FutureOr<Null> onError(e) {
    SnackBar snackBar = SnackBar(
      content: Text(e.toString()),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); //hide previous prompt if exists
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}