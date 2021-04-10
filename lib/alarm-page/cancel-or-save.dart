import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/global_events.dart';
import 'package:sleep/main.dart';

class CancelOrSave extends StatelessWidget {
  // final int minutes;
  // final bool sunday, monday, tuesday, wednesday, thursday, friday, saturday;
  final AlarmBloc alarmBloc;
  CancelOrSave({
    @required this.alarmBloc,
    // @required this.minutes,
    // @required this.sunday,
    // @required this.monday,
    // @required this.tuesday,
    // @required this.wednesday,
    // @required this.thursday,
    // @required this.friday,
    // @required this.saturday,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      child: Row(children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).cancel,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () {
                alarmBloc.sink.add(
                  SetAlarm(
                      // minutes: this.minutes,
                      // sunday: this.sunday,
                      // monday: this.monday,
                      // tuesday: this.tuesday,
                      // wednesday: this.wednesday,
                      // thursday: this.thursday,
                      // friday: this.friday,
                      // saturday: this.saturday,
                      ),
                );
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context).save,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
