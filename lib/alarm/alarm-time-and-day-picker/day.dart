import 'package:flutter/material.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_event.dart';

class Day extends StatelessWidget {
  final String day;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  final AlarmTimeAndDayPickerEvent dayToSetTo;
  Day({
    @required this.day,
    @required this.alarmTimeAndDayPickerBloc,
    @required this.dayToSetTo,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(5),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 45, height: 45),
          child: ElevatedButton(
            child: Text(
              day,
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () =>
                this.alarmTimeAndDayPickerBloc.eventSink.add(dayToSetTo),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(
                  side: BorderSide(
                width: 0,
              )),
            ),
          ),
        ),
      ),
    ]);
  }
}
