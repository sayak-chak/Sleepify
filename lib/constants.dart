import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  static const int ALARM_TIME_PICKER_INDEX = 3;
  static const int ALARM_PAGE_INDEX = 2;
  static const int SLEEP_MUSIC_INDEX = 1;
  static const int HOME_PAGE_INDEX = 0;

  static int ALARM_PAGE_ALARM_LIST_INDEX = 0;
  static int ALARM_PAGE_ALARM_TIME_PICKER_INDEX = 1;

  static const int NUMBER_OF_SLEEP_SONGS_IN_EACH_GROUP = 10;

  static const int SLEEP_MUSIC_TYPE_NATURE = 0;
  static const int SLEEP_MUSIC_TYPE_MECHANICAL = 1;
  static const int SLEEP_MUSIC_TYPE_PLANETARY = 2;

  static final MUSIC_FILE_CORRESPONDING_TO_ICON_INDEX = [
    [
      "animals-and-birds/animal-conversation.mp3",
      "animals-and-birds/animals-in-wetlands.mp3",
      "animals-and-birds/bird-call-in-spring.mp3",
      "animals-and-birds/croaking-frogs.mp3",
      "animals-and-birds/cuckoo.mp3",
      "animals-and-birds/frogs.mp3",
      "animals-and-birds/grasshoppers.mp3",
      "animals-and-birds/spring-birds-at-night.mp3",
      "animals-and-birds/walking-with-dog.mp3",
      "animals-and-birds/trottling-horse.mp3"
    ],
    [ 
      "asmr-and-focus/delta-wave.mp3",
      "asmr-and-focus/guitar-1.mp3",
      "asmr-and-focus/guitar-2.mp3",
      "asmr-and-focus/orchestra.mp3",
      "asmr-and-focus/scissors-in-air.mp3",
      "asmr-and-focus/tibetian-bowl.mp3",
      "asmr-and-focus/violin-1.mp3",
      "asmr-and-focus/white-noise.mp3",
      "asmr-and-focus/white-noise-2.mp3",
      "asmr-and-focus/wind-chime.mp3"
    ],
    [
      "nature/digging.mp3",
      "nature/firewood.mp3",
      "nature/iceberg.mp3",
      "nature/rain-1.mp3",
      "nature/rain-2.mp3",
      "nature/thunder-1.mp3",
      "nature/thunder-rain.mp3",
      "nature/water-flow-1.mp3",
      "nature/wind-1.mp3",
      "nature/wind-2.mp3"
    ],
  ]; //TODO : 2D array tightly coupled with icon data list

  static final ICON_DATA_LIST = [
    List.generate(Constants.NUMBER_OF_SLEEP_SONGS_IN_EACH_GROUP, (index) {
      if (index % 2 == 0) return FontAwesomeIcons.plus;
      return FontAwesomeIcons.addressCard;
    }),
    List.generate(Constants.NUMBER_OF_SLEEP_SONGS_IN_EACH_GROUP, (index) {
      if (index % 2 == 0) return FontAwesomeIcons.minus;
      return FontAwesomeIcons.addressCard;
    }),
    List.generate(Constants.NUMBER_OF_SLEEP_SONGS_IN_EACH_GROUP, (index) {
      if (index % 2 == 0) return FontAwesomeIcons.addressBook;
      return FontAwesomeIcons.addressCard;
    })
  ];

  static const int MAX_NO_OF_CONCURRENT_SOUNDS = 2;
}
