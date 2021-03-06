import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sleepify/alarm/alarm-list/alarm-list.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_bloc.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_state.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/alarm-time-and-day-picker.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_bloc.dart';
import 'package:Sleepify/constants.dart';

class AlarmScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmScreenState();
}

class AlarmScreenState extends State<AlarmScreen> {
  AlarmPageBloc _alarmPageBloc;
  AlarmTimeAndDayPickerBloc _alarmTimeAndDayPickerBloc;
  // AlarmListBloc _alarmListBloc;

  @override
  void initState() {
    _alarmPageBloc = AlarmPageBloc();
    _alarmTimeAndDayPickerBloc =
        AlarmTimeAndDayPickerBloc(alarmPageBloc: _alarmPageBloc);
    // _alarmListBloc = AlarmListBloc();
    super.initState();
  }

  @override
  void dispose() {
    _alarmPageBloc.close();
    _alarmTimeAndDayPickerBloc.close();
    // _alarmListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _alarmPageBloc,
        builder: (BuildContext context, AlarmPageState alarmPageState) {
          if (alarmPageState is UpdateAlarmScreen &&
              alarmPageState.screenIndex ==
                  Constants.ALARM_PAGE_ALARM_TIME_PICKER_INDEX) {
            return AlarmTimeAndDayPicker(
              alarmTimeAndDayPickerBloc: _alarmTimeAndDayPickerBloc,
              alarmPageBloc: _alarmPageBloc,
            );
          }
          return AlarmList(
            alarmPageBloc: _alarmPageBloc,
          );
        });
  }
}
