import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:Sleepify/alarm/alarm-page/alarm-page.dart';
import 'package:Sleepify/bottom-nav-bar/bloc/bottom_nav_event.dart';
import 'package:Sleepify/bottom-nav-bar/bloc/botton_nav_bloc.dart';
import 'package:Sleepify/bottom-nav-bar/bottom-navigaton-bar.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';
import 'package:Sleepify/sleep-music/sleep-music.dart';
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
  AssetImage bGImage;

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
      AlarmScreen(),
    ];
    bGImage = AssetImage("images/moonlight.jpg");
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bGImage, context);
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
      title: '',
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
                  image: AssetImage("images/moonlight.jpg"), fit: BoxFit.fill),
            ),
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            padding: EdgeInsets.only(
              top: 40,
              bottom: 40,
              left: 10,
              right: 10,
            ), //TODO: WHAT TO DO???
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
