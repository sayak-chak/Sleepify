import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep/alarm/alarm-page.dart';
import 'package:sleep/bottom-nav-bar/bloc/bottom_nav_event.dart';
import 'package:sleep/bottom-nav-bar/bloc/botton_nav_bloc.dart';
import 'package:sleep/bottom-nav-bar/bottom-navigaton-bar.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/errors/error-bloc/error_event.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';
import 'package:sleep/sleep-music/sleep-music.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  PlayPauseButtonBloc sleepMusicBloc;
  SleepMusicIconBloc sleepMusicIconBloc;
  ErrorBloc errorBloc;
  BottomNavBarBloc bottomNavBarBloc;
  List<Widget> APP_BODY_LIST;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    sleepMusicBloc = PlayPauseButtonBloc();
    sleepMusicIconBloc = SleepMusicIconBloc();
    errorBloc = ErrorBloc();
    bottomNavBarBloc = BottomNavBarBloc();
    APP_BODY_LIST = [
      SleepMusic(),
      AlarmPage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    sleepMusicBloc.close();
    sleepMusicIconBloc.close();
    errorBloc.close();
    bottomNavBarBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
      ],
      title: 'Flutter Demo',
      home: MultiBlocProvider(
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
          ),
          BlocProvider<BottomNavBarBloc>(
            create: (BuildContext context) =>
                bottomNavBarBloc..add(ChangeAppBody(updatedAppBodyIndex: 0)),
          )
        ],
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/moonlight.jpeg"), fit: BoxFit.fill),
            ),
            child: BlocBuilder(
              bloc: bottomNavBarBloc,
              builder: (BuildContext context, state) {
                if (state is int) return APP_BODY_LIST[state];
                return APP_BODY_LIST[0];
              },
            ),
          ),
          bottomNavigationBar: SleepAppBottomNavigationBar(),
        ),
      ),
    );
  }
}
