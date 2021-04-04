import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep/alarm-page/time-picker.dart';
import 'package:sleep/main.dart';
import 'package:sleep/alarm-page/alarm_time.dart';
import 'package:sleep/constants.dart';

class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  List<AlarmTime> _listOfAlarms;
  bool _showAlarmSetup;

  @override
  void initState() {
    // TODO: implement initState
    _listOfAlarms = listOfAlarms;
    _showAlarmSetup = false;
    print(" ++++++++++ =>>>> " + _showAlarmSetup.toString());
  }

  void dontDisplayAlarmList() {
    setState(() {
      _showAlarmSetup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Row(children: [
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: _showAlarmSetup
                        ? Container()
                        : Align(
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
                                  _showAlarmSetup = true;
                                });
                              },
                            ),
                          ),
                  ),
                ]),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 100, bottom: 100),
              //   width: (MediaQuery.of(context).size.width / 3) * 2,
              //   child: ShaderMask(
              //     shaderCallback: (Rect rect) {
              //       return LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [
              //           Colors.purple,
              //           Colors.transparent,
              //           Colors.transparent,
              //           Colors.purple
              //         ],
              //         stops: [
              //           0.0,
              //           0.1,
              //           0.9,
              //           1.0
              //         ], // 10% purple, 80% transparent, 10% purple
              //       ).createShader(rect);
              //     },
              //     blendMode: BlendMode.dstOut,
              //     child: ListView(
              //       padding: EdgeInsets.all(5),
              //       children: [..._listOfAlarms],
              //     ),
              //   ),
              // ),
              TimePicker(),
            ],
          ),
          // Container(
          //   // alignment: Alignment.centerLeft,
          //     width: MediaQuery.of(context).size.width / 6,
          //     // color: Colors.black54,
          //     child: Row(
          //       children: [
          //         TextButton(
          //           onPressed: () {},
          //           child: Text(
          //             "Save",
          //             style: TextStyle(
          //               fontSize: 15,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
