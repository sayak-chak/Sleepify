import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static final List<Text> listOfHours = new List<Text>.generate(
    24,
    (index) => index >= 10
        ? Text(
            index.toString(),
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        : Text(
            '0' + index.toString(),
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.white),
          ),
  );
  static final List<Text> listOfMins = new List<Text>.generate(
    60,
    (index) => index >= 10
        ? Text(
            index.toString(),
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.white),
          )
        : Text(
            '0' + index.toString(),
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.white),
          ),
  );
  static const ROUTE_CORRESPONDING_TO_INDEX = ['/alarm', '/asmr'];

  static const Color DEFAULT_BUTTON_COLOR_NON_SOLID =
      Color.fromRGBO(250, 214, 165, 0.5);
  // static const Color DEFAULT_BUTTON_COLOR_SOLID = Color.fromRGBO(250, 214, 165, 0.5);
  static const Color DEFAULT_RIGHT_COLOR = Colors.green;
  static const Color DEFAULT_WRONG_COLOR = Colors.redAccent;

  static const double MEDIUM_SIZE = 20;
  static const double LARGE_SIZE = 30;
}
