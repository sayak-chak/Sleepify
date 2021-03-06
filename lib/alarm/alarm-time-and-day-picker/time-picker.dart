import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_bloc.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_event.dart';
import 'package:Sleepify/constants.dart';

class TimePicker extends StatelessWidget {
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  TimePicker({@required this.alarmTimeAndDayPickerBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      // margin: EdgeInsets.only(top: 50, left: 40, right: 40),
      // width: 300,
      child: Row(
        children: [
          Flexible(
            child: Container(
              // width: 150,
              height: 200,
              child: CupertinoPicker(
                looping: true,
                backgroundColor: Colors.black54,
                magnification: 1.15,
                onSelectedItemChanged: (hr) =>
                    alarmTimeAndDayPickerBloc.add(SetHours(hours: hr)),
                itemExtent: 50,
                children: [...Constants.listOfHours],
              ),
            ),
          ),
          Flexible(
            child: Container(
              // width: 140,
              color: Colors.black54,
              alignment: Alignment.center,
              // width: 60,
              height: 200,
              child: Text(
                ":",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              // width: 150,
              height: 200,
              child: CupertinoPicker(
                looping: true,
                backgroundColor: Colors.black54,
                magnification: 1.15,
                onSelectedItemChanged: (min) =>
                    alarmTimeAndDayPickerBloc.add(SetMinutes(minutes: min)),
                itemExtent: 50,
                children: [...Constants.listOfMins],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
