import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sleep/alarm-page/alarm-page.dart';
import 'package:sleep/alarm-page/setup-alarm.dart';
import 'package:sleep/components/bottom-navigaton-bar.dart';

import 'package:sleep/power-nap/power-nap.dart';
import 'home/home.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
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
        '/alarm': (BuildContext context) => AlarmPage(),
        '/setup-alarm' : (BuildContext context) => SetupAlarm(alarmList: [],),
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
          child: Home(),
        ),
        bottomNavigationBar: SleepAppBottomNavigationBar(),
      ),
    );
  }
}

//imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
