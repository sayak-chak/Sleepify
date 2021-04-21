import 'package:flutter/material.dart';

abstract class AlarmEvent {}

class UpdateAlarmPageScreen extends AlarmEvent {
  int screenIndex;
  UpdateAlarmPageScreen({@required this.screenIndex});
}
