import 'package:flutter/material.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_events.dart';

class Day extends StatelessWidget {
  final String day;
  final AlarmBloc alarmBloc;
  final AlarmEvent updateDay;
  Day({
    @required this.day,
    @required this.alarmBloc,
    @required this.updateDay,
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
            onPressed: () => this.alarmBloc.sink.add(updateDay),
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
