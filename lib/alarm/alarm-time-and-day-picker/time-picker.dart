import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_event.dart';
import 'package:sleep/constants.dart';

class TimePicker extends StatelessWidget {
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  TimePicker({@required this.alarmTimeAndDayPickerBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
                    alarmTimeAndDayPickerBloc.eventSink.add(SetHours(hours: hr)),
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
                    alarmTimeAndDayPickerBloc.eventSink.add(SetMinutes(minutes: min)),
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
