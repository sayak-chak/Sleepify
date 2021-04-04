import 'package:flutter/material.dart';
import 'package:sleep/main.dart';
import 'package:sleep/alarm-page/alarm_time.dart';
import 'package:sleep/constants.dart';

class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  List<AlarmTime> _listOfAlarms;

  @override
  void initState() {
    // TODO: implement initState
    _listOfAlarms = listOfAlarms;
  }

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
                    onPressed: () {
                      setState(() {
                        _listOfAlarms.add(AlarmTime());
                      });
                    },
                  ),
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 100, bottom: 100),
            width: (MediaQuery.of(context).size.width / 3) * 2,
            child: ListView(
              padding: EdgeInsets.all(5),
              children: [..._listOfAlarms],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
