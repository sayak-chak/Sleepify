import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/alarm-page/day.dart';

class WeekDayPicker extends StatelessWidget {
  final AlarmBloc alarmBloc;
  WeekDayPicker({@required this.alarmBloc});
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
                    alarmBloc: alarmBloc,
                    updateDay: UpdateSunday(),
                  ),
                  Day(
                    day: "M",
                    alarmBloc: alarmBloc,
                    updateDay: UpdateMonday(),
                  ),
                  Day(
                    day: "T",
                    alarmBloc: alarmBloc,
                    updateDay: UpdateTuesday(),
                  ),
                  Day(
                    day: "W",
                    alarmBloc: alarmBloc,
                    updateDay: UpdateWednesday(),
                  ),
                  Day(
                    day: "T",
                    alarmBloc: alarmBloc,
                    updateDay: UpdateThursday(),
                  ),
                  Day(
                    day: "F",
                    alarmBloc: alarmBloc,
                    updateDay: UpdateFriday(),
                  ),
                  Day(
                    day: "S",
                    alarmBloc: alarmBloc,
                    updateDay: UpdateSaturday(),
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
