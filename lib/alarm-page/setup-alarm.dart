import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alarm_time.dart';

class SetupAlarm extends StatelessWidget {
  final List<AlarmTime> alarmList;
  SetupAlarm({@required this.alarmList});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      child: ListView(
        children: [
          CupertinoPicker(
            itemExtent: 30,
            onSelectedItemChanged: (int value) {
              print(value);
            },
            children: [Text('1'), Text('2'), Text('3')],
          )
        ],
      ),
    );
  }
}
