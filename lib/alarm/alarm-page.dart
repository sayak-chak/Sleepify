import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep/alarm/ALARM-BLOC/alarm_bloc.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/alarm-list/alarm-list.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/alarm-time-and-day-picker.dart';
import 'package:sleep/constants.dart';

class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  AlarmBloc _alarmBloc;
  AlarmTimeAndDayPickerBloc _alarmTimeAndDayPickerBloc;
  // AlarmListBloc _alarmListBloc;

  @override
  void initState() {
    _alarmBloc = AlarmBloc();
    _alarmTimeAndDayPickerBloc = AlarmTimeAndDayPickerBloc();
    // _alarmListBloc = AlarmListBloc();
    super.initState();
  }

  @override
  void dispose() {
    _alarmBloc.dispose();
    _alarmTimeAndDayPickerBloc.dispose();
    // _alarmListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _alarmBloc.stateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data == Constants.ALARM_PAGE_ALARM_TIME_PICKER_INDEX) {
            return AlarmTimeAndDayPicker(
              alarmTimeAndDayPickerBloc: _alarmTimeAndDayPickerBloc,
              alarmBloc: _alarmBloc,
            );
          }
          return AlarmList(
            alarmBloc: _alarmBloc,
          );
        });
  }
}
