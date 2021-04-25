import 'package:flutter/material.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_event.dart';

class Day extends StatefulWidget {
  final String day;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  final AlarmTimeAndDayPickerEvent dayToSetTo;
  Day({
    @required this.day,
    @required this.alarmTimeAndDayPickerBloc,
    @required this.dayToSetTo,
  });

  @override
  State<StatefulWidget> createState() => DayState(
        day: day,
        alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
        dayToSetTo: dayToSetTo,
        isPressed: false,
      );
}

class DayState extends State<Day> {
  final String day;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  final AlarmTimeAndDayPickerEvent dayToSetTo;
  bool isPressed;
  DayState(
      {@required this.day,
      @required this.alarmTimeAndDayPickerBloc,
      @required this.dayToSetTo,
      @required this.isPressed});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? Colors.white : Colors.black54,
          // border: BoxBorder.lerp(a, b, t)
          // borderRadius: BorderRadius.all(Radius.circular(1)),
        ),
        child: ElevatedButton(
          child: Text(
            day,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: () {
            this.alarmTimeAndDayPickerBloc.add(dayToSetTo);
            setState(() {
              isPressed = !isPressed;
            });
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            minimumSize: Size(40, 40),
            shape: CircleBorder(
                side: BorderSide(
              width: 0,
            )),
          ),
        ),
      ),
    ]);
  }
}
