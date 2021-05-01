import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_bloc.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_events.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_bloc.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_event.dart';
import 'package:Sleepify/constants.dart';

class CancelOrSave extends StatelessWidget {
  final AlarmPageBloc alarmPageBloc;
  final AlarmTimeAndDayPickerBloc alarmTimeAndDayPickerBloc;

  CancelOrSave(
      {@required this.alarmPageBloc, @required this.alarmTimeAndDayPickerBloc});

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
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () => alarmPageBloc.add(
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
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () async {
                alarmTimeAndDayPickerBloc.add(
                  SetAlarm(),
                );
                Future.delayed(
                    Duration(milliseconds: 100),
                    () => alarmPageBloc.add(UpdateAlarmPageScreen(
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
