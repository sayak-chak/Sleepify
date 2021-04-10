import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sleep/alarm-page/alarm-page.dart';
import 'package:sleep/alarm-page/alarm-time-picker.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_time.dart';
import 'package:sleep/components/bottom-navigaton-bar.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/global_bloc.dart';
import 'package:sleep/navigator-history.dart';

import 'package:sleep/power-nap/power-nap.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
List<AlarmTime> listOfAlarms = <AlarmTime>[];
// final AlarmPage alarmPage = AlarmPage();
final GLOBAL_BLOC = GlobalBloc();

final APP_BODY_LIST = [
  Container(
    width: 40,
    color: Colors.red,
    child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [Text("sfsdfdsf"), Text("asdsadsad")],
    ),
  ),
  Container(
    width: 40,
    color: Colors.red,
    child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [Text("sfsdfdsf"), Text("asdsadsad")],
    ),
  ),
  AlarmPage(),
  // AlarmTimePicker()
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorObservers: [H istoryLimit(limit: 2)],
      routes: <String, WidgetBuilder>{
        '/powerNap': (BuildContext context) => PowerNap(),
        '/alarm': (BuildContext context) => AlarmPage(),
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
      ],
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/moonlight.jpeg"), fit: BoxFit.fill),
          ),
          child: StreamBuilder(
            stream: GLOBAL_BLOC.appBodyIndex,
            builder: (context, snapshot) {
              if (snapshot.hasData) return APP_BODY_LIST[snapshot.data];
              return APP_BODY_LIST[Constants.HOME_PAGE_INDEX];
            },
          ),
        ),
        bottomNavigationBar: SleepAppBottomNavigationBar(),
      ),
    );
  }
}

class PickAlarmTimeRoute extends StatelessWidget {
  //TODO : refactor asap
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [HistoryLimit(limit: 2)],
      routes: <String, WidgetBuilder>{
        '/powerNap': (BuildContext context) => PowerNap(),
        '/alarm': (BuildContext context) => AlarmPage(),
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
      ],
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/moonlight.jpeg"), fit: BoxFit.fill),
          ),
          child: AlarmTimePicker()
          // StreamBuilder(
          //   stream: GLOBAL_BLOC.appBodyIndex,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) return APP_BODY_LIST[snapshot.data];
          //     return AlarmTimePicker(alarmBloc: AlarmBloc());
          //   },
          // ),
        ),
        // bottomNavigationBar: SleepAppBottomNavigationBar(),
      ),
    );
  }
}

//imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
