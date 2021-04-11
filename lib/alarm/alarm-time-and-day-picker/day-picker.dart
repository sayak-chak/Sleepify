import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_event.dart';
import 'package:sleep/alarm/alarm-time-and-day-picker/day.dart';

class WeekDayPicker extends StatelessWidget {
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;
  WeekDayPicker({@required this.alarmTimeAndDayPickerBloc});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SizedBox(
        height: 150,
        child: Container(
          color: Colors.green,
          width: 385,
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
    );
  }
}
