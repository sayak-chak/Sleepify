import 'package:flutter/material.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_bloc.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_event.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/day.dart';

class WeekDayPicker extends StatelessWidget {
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  WeekDayPicker({@required this.alarmTimeAndDayPickerBloc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.red,
        //   border: Border.all(
        //     color: Colors.white,
        //   ),
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(5),
        //   ),
        // ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.all(
          //   Radius.circular(18.0),
          // ),
          // color: Colors.red,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.blueAccent,
          //     spreadRadius: 4,
          //     blurRadius: 4,
          //   ),
          //   BoxShadow(
          //     color: Colors.blueAccent,
          //     spreadRadius: -4,
          //     blurRadius: 4,
          //   )
          // ],
        ),
        padding: EdgeInsets.all(5),
        child: SizedBox(
          height: 52,
          child: Container(
            // color: Colors.green,
            // width: 385,
            alignment: Alignment.center,
            child: Column(children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Day(
                      day: "S",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToSunday(),
                    ),
                    Day(
                      day: "M",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToMonday(),
                    ),
                    Day(
                      day: "T",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToTuesday(),
                    ),
                    Day(
                      day: "W",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToWednesday(),
                    ),
                    Day(
                      day: "T",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToThursday(),
                    ),
                    Day(
                      day: "F",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToFriday(),
                    ),
                    Day(
                      day: "S",
                      alarmTimeAndDayPickerBloc: alarmTimeAndDayPickerBloc,
                      dayToSetTo: SetToSaturday(),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
