import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/alarm-page/alarm_time.dart';
import 'package:sleep/constants.dart';

class AlarmPage extends StatelessWidget {
  final _alarmBloc = AlarmBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 6,
            child: Row(children: [
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.add,
                      size: 50,
                      color: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
                    ),
                    onPressed: () => _alarmBloc.alarmEventSink
                        .add(AddAlarm(alarmTime: AlarmTime())),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 100, bottom: 100),
            width: (MediaQuery.of(context).size.width / 3) * 2,
            child: StreamBuilder(
              initialData: <AlarmTime>[],
              stream: _alarmBloc.alarmList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("+++++===============> " +
                      snapshot.data.length.toString());
                  return ListView(
                    padding: EdgeInsets.all(5),
                    children: [...snapshot.data],
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
