import 'package:flutter/material.dart';

abstract class AlarmPageEvent {}

class UpdateAlarmPageScreen extends AlarmPageEvent {
  int screenIndex;
  UpdateAlarmPageScreen({@required this.screenIndex});
}
