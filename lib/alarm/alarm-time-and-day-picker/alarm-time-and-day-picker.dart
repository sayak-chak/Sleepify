import 'dart:async';

import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:Sleepify/errors/error-bloc/error_state.dart';
import 'package:Sleepify/errors/error-dialog-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_bloc.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_bloc.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/cancel-or-save.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/day-picker.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/time-picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmTimeAndDayPicker extends StatelessWidget {
  final AlarmPageBloc alarmPageBloc;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;

  AlarmTimeAndDayPicker(
      {@required this.alarmPageBloc, @required this.alarmTimeAndDayPickerBloc});
  @override
  Widget build(BuildContext context) {
    final _errorBloc = BlocProvider.of<ErrorBloc>(context);
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 50,
        bottom: 50,
      ),
      // alignment: Alignment.center,
      child: Stack(children: [
        ListView(
          children: [
            TimePicker(
              alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
            ),
            WeekDayPicker(
              alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
            ),
            CancelOrSave(
                alarmPageBloc: alarmPageBloc,
                alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc),
          ],
        ),
        BlocBuilder(
          bloc: _errorBloc,
          builder: (BuildContext context, ErrorState state) {
            if (state is DisplayError) {
              Timer(Duration(seconds: 1), () {
                _errorBloc.add(RemoveError());
              });
              return ErrorDialog(errorMessage: state.errorMessage);
            }
            return Container();
          },
        ),
      ]),
    );
  }
}
