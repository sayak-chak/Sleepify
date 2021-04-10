import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/alarm-page/cancel-or-save.dart';
import 'package:sleep/alarm-page/time-picker.dart';
import 'package:sleep/alarm-page/week-day-picker.dart';
import 'package:sleep/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sleep/global_events.dart';

class AlarmTimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmTimePickerState();
}

class AlarmTimePickerState extends State<AlarmTimePicker> {
  AlarmBloc _alarmBloc;

  @override
  void initState() {
    _alarmBloc = AlarmBloc();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    _alarmBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 50,
        bottom: 50,
      ),
      // alignment: Alignment.center,
      child: ListView(children: [
        TimePicker(
          alarmBloc: _alarmBloc,
        ),
        WeekDayPicker(
          alarmBloc: _alarmBloc,
        ),
        CancelOrSave(alarmBloc: _alarmBloc),
      ]),
    );
  }
}
