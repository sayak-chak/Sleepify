import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep/alarm/ALARM-BLOC/alarm_bloc.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/cancel-or-save.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/day-picker.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/time-picker.dart';
  
class AlarmTimeAndDayPicker extends StatelessWidget {
  final AlarmBloc alarmBloc;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;

  AlarmTimeAndDayPicker(
      {@required this.alarmBloc, @required this.alarmTimeAndDayPickerBloc});
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
          alarmTimeAndDayPickerBloc : alarmTimeAndDayPickerBloc,
        ),
        WeekDayPicker(
          alarmTimeAndDayPickerBloc : alarmTimeAndDayPickerBloc,
        ),
        CancelOrSave(alarmBloc: alarmBloc, alarmTimeAndDayPickerBloc : alarmTimeAndDayPickerBloc),
      ]),
    );
  }
}
