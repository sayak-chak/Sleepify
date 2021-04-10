import 'package:flutter/material.dart';

abstract class AlarmEvent {}

/// minutes specifies the time in minute, ex - 00:21 -> 21, 04:34 -> 274
/// boolean values represent if alarm is set on those days
class SetAlarm extends AlarmEvent {
  // final int minutes;
  // final bool sunday, monday, tuesday, wednesday, thursday, friday, saturday;
  SetAlarm(
      // {
      // @required this.minutes,
      // @required this.sunday,
      // @required this.monday,
      // @required this.tuesday,
      // @required this.wednesday,
      // @required this.thursday,
      // @required this.friday,
      // @required this.saturday,
      // }
      );
}

class SetHours extends AlarmEvent {
  final int hours;
  SetHours({@required this.hours});
}

class SetMinutes extends AlarmEvent {
  final int minutes;
  SetMinutes({@required this.minutes});
}

class UpdateSunday extends AlarmEvent {}

class UpdateMonday extends AlarmEvent {}

class UpdateTuesday extends AlarmEvent {}

class UpdateWednesday extends AlarmEvent {}

class UpdateThursday extends AlarmEvent {}

class UpdateFriday extends AlarmEvent {}

class UpdateSaturday extends AlarmEvent {}
