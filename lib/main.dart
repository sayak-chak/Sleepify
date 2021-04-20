import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sleep/alarm/alarm-page.dart';
import 'package:sleep/components/bottom-navigaton-bar.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/GLOBAL-BLOC/BOTTOM-NAV-BLOC/botton_nav_bloc.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/errors/error-bloc/error_event.dart';

import 'package:sleep/power-nap/power-nap.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';
import 'package:sleep/sleep-music/sleep-music.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// List<AlarmTime> listOfAlarms = <AlarmTime>[];
// final AlarmPage alarmPage = AlarmPage();
final GLOBAL_BOTTOM_NAV_BLOC = BottomNavBarBloc();
final sleepMusicBloc = PlayPauseButtonBloc();
final sleepMusicIconBloc = SleepMusicIconBloc();
final errorBloc = ErrorBloc();

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
  SleepMusic(),
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider<PlayPauseButtonBloc>(
              create: (BuildContext context) => sleepMusicBloc,
            ),
            BlocProvider<SleepMusicIconBloc>(
              create: (BuildContext context) =>
                  sleepMusicIconBloc..add(LoadSleepMusicIconsFromDB()),
            ),
            BlocProvider<ErrorBloc>(
              create: (BuildContext context) => errorBloc..add(RemoveError()),
            )
          ],
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/moonlight.jpeg"), fit: BoxFit.fill),
            ),
            child: StreamBuilder(
              stream: GLOBAL_BOTTOM_NAV_BLOC.appBodyIndex,
              builder: (context, snapshot) {
                if (snapshot.hasData) return APP_BODY_LIST[snapshot.data];
                return APP_BODY_LIST[Constants.HOME_PAGE_INDEX];
              },
            ),
          ),
        ),
        bottomNavigationBar: SleepAppBottomNavigationBar(),
      ),
    );
  }
}

//imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
