import 'package:flutter/material.dart';

abstract class AlarmTimeAndDayPickerEvent {}

class SetHours extends AlarmTimeAndDayPickerEvent {
  final int hours;
  SetHours({@required this.hours});
}

class SetMinutes extends AlarmTimeAndDayPickerEvent {
  final int minutes;
  SetMinutes({@required this.minutes});
}

class SetAlarm extends AlarmTimeAndDayPickerEvent {}

class SetToSunday extends AlarmTimeAndDayPickerEvent {}

class SetToMonday extends AlarmTimeAndDayPickerEvent {}

class SetToTuesday extends AlarmTimeAndDayPickerEvent {}

class SetToWednesday extends AlarmTimeAndDayPickerEvent {}

class SetToThursday extends AlarmTimeAndDayPickerEvent {}

class SetToFriday extends AlarmTimeAndDayPickerEvent {}

class SetToSaturday extends AlarmTimeAndDayPickerEvent {}
