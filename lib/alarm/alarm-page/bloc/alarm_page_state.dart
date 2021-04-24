import 'package:flutter/material.dart';

abstract class AlarmPageState {}

class UpdateAlarmScreen extends AlarmPageState {
  final int screenIndex;
  UpdateAlarmScreen({@required this.screenIndex});
}
