import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sleep/alarm/ALARM-BLOC/alarm_bloc.dart';
import 'package:sleep/alarm/ALARM-BLOC/alarm_events.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_bloc.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_event.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/GLOBAL-BLOC/BOTTOM-NAV-BLOC/botton_nav_bloc.dart';
import 'package:sleep/GLOBAL-BLOC/BOTTOM-NAV-BLOC/bottom_nav_event.dart';
import 'package:sleep/main.dart';

class CancelOrSave extends StatelessWidget {
  final AlarmBloc alarmBloc;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;

  CancelOrSave(
      {@required this.alarmBloc, @required this.alarmTimeAndDayPickerBloc});

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
              onPressed: () => alarmBloc.eventSink.add(
                UpdateAlarmPageScreen(
                  screenIndex: Constants.ALARM_PAGE_ALARM_LIST_INDEX,
                ),
              ),
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
              onPressed: () async {
                alarmTimeAndDayPickerBloc.eventSink.add(
                  SetAlarm(),
                );
                Future.delayed(
                    Duration(milliseconds: 100),
                    () => alarmBloc.eventSink.add(UpdateAlarmPageScreen(
                        screenIndex: Constants.ALARM_PAGE_ALARM_LIST_INDEX)));
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
