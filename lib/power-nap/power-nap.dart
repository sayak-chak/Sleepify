import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sleep/utils/button.dart';
import 'package:sleep/utils/constants.dart';

import 'package:android_alarm_manager/android_alarm_manager.dart';

class PowerNap extends StatefulWidget {
  @override
  State<PowerNap> createState() {
    return _PowerNapState();
  }
}

class _PowerNapState extends State<PowerNap> {
  void printHello() {
    print("Hello");
    // final DateTime now = DateTime.now();
    // final int isolateId = Isolate.current.hashCode;
    // print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
  }

  final int helloAlarmID = 0;
  Future<void> aa() async {
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(
        const Duration(minutes: 1), helloAlarmID, printHello);
    // await AndroidAlarmManager.oneShot(const Duration(minutes: 1), helloAlarmID,
    //     () {
    //   Navigator.pop(context);
    //   return 1;
    // });
  }

  String val = 'One';
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(255, 255, 255, 0),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 4,
          bottom: MediaQuery.of(context).size.height / 4,
          left: 30,
          right: 30,
        ),
        // color: Color.fromRGBO(0, 0, 0, 0),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
        child: ListView(
          children: [
            Button(
              buttonTitle: "5 minutes",
              onPressed: () {
                aa();
              },
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Button(
              buttonTitle: "10 minutes",
              onPressed: () {},
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Button(
              buttonTitle: "15 minutes",
              onPressed: () {},
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Button(
              buttonTitle: "20 minutes",
              onPressed: () {},
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Row(
              children: [
                Expanded(
                    child: Button(
                  buttonTitle: "✔",
                  onPressed: () {},
                  buttonColor: Constants.DEFAULT_RIGHT_COLOR,
                  fontSize: Constants.LARGE_SIZE,
                )),
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    child: Button(
                  buttonTitle: "✘",
                  onPressed: () {},
                  buttonColor: Constants.DEFAULT_WRONG_COLOR,
                  fontSize: Constants.LARGE_SIZE,
                )),
              ],
            )
          ],
        ));
  }
}
