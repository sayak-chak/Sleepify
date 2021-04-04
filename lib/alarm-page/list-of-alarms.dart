import 'package:flutter/material.dart';
import 'package:sleep/alarm-page/alarm_time.dart';

class ListOfAlarms extends StatelessWidget {
  final List<AlarmTime> listOfAlarms;
  ListOfAlarms({@required this.listOfAlarms});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100, bottom: 100),
      width: (MediaQuery.of(context).size.width / 3) * 2,
      child: ListView(
        padding: EdgeInsets.all(5),
        children: [...listOfAlarms],
      ),
    );
  }
}
