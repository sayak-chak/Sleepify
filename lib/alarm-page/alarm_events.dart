import 'package:flutter/material.dart';
import 'package:sleep/alarm-page/alarm_time.dart';

abstract class AlarmEvent {}

class AddAlarm extends AlarmEvent {
  AlarmTime alarmTime; //TODO : fix
  AddAlarm({@required this.alarmTime});
}
