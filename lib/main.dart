import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sleep/alarm-page/alarm-page.dart';
import 'package:sleep/alarm-page/alarm-time-picker.dart';
import 'package:sleep/alarm-page/alarm_time.dart';
import 'package:sleep/alarm-page/setup-alarm.dart';
import 'package:sleep/components/bottom-navigaton-bar.dart';
import 'package:sleep/global_bloc.dart';

import 'package:sleep/power-nap/power-nap.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
List<AlarmTime> listOfAlarms = <AlarmTime>[];
// final AlarmPage alarmPage = AlarmPage();
final GLOBAL_BLOC = GlobalBloc();

final APP_BODY_LIST = [Container(), AlarmTimePicker()];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/powerNap': (BuildContext context) => PowerNap(),
        '/alarm': (BuildContext context) => AlarmTimePicker(),
        '/setup-alarm': (BuildContext context) => SetupAlarm(
              alarmList: [],
            ),
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
              return APP_BODY_LIST[0];
            },
          ),
        ),
        bottomNavigationBar: SleepAppBottomNavigationBar(),
      ),
    );
  }
}

//imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
