import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/database-client.dart';
import 'package:sleep/global_events.dart';
import 'package:sleep/alarm-page/alarm-page.dart';
import 'package:sleep/datatbase.dart';

//TODO : using impure func (mutating class vars), antipattern in block design pattern, refactor ASAP
//TODO : break in two separate blocs
class AlarmBloc {

  int _hours, _minutes;
  bool _sunday, _monday, _tuesday, _wednesday, _thursday, _friday, _saturday;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _alarmEventController = StreamController<AlarmEvent>();
  // final _alarmStateController = StreamController<dynamic>();

  Sink<AlarmEvent> get sink => _alarmEventController.sink;

  AlarmBloc() {
    _hours = 0;
    _minutes = 0;
    _sunday = false;
    _monday = false;
    _tuesday = false;
    _wednesday = false;
    _thursday = false;
    _friday = false;
    _saturday = false;
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    _flutterLocalNotificationsPlugin.initialize(
      initSetttings,
    );
    _alarmEventController.stream.listen(_mapAlarmEventsToState);
  }

  void _mapAlarmEventsToState(event) {
    if (event is SetAlarm) {
      // _showNotificationMediaStyle();
      _updateDatabase();
      // print("===========>>>>>>>");
      // print(_hours * 60 + _minutes);
      // print("Sunday = " + _sunday.toString());
      // print("Monday = " + _monday.toString());
      // print("Tuesday = " + _tuesday.toString());
      // print("Wednesday = " + _wednesday.toString());
      // print("Thursday = " + _thursday.toString());
      // print("Friday = " + _friday.toString());
      // print("Saturday = " + _saturday.toString());
      // print("=============>>>>>>>>>>>>>");
    } else if (event is SetHours) {
      _hours = event.hours;
    } else if (event is SetMinutes) {
      _minutes = event.minutes;
    } else if (event is UpdateSunday) {
      _sunday = !_sunday;
    } else if (event is UpdateMonday) {
      _monday = !_monday;
    } else if (event is UpdateTuesday) {
      _tuesday = !_tuesday;
    } else if (event is UpdateWednesday) {
      _wednesday = !_wednesday;
    } else if (event is UpdateThursday) {
      _thursday = !_thursday;
    } else if (event is UpdateFriday) {
      _friday = !_friday;
    } else if (event is UpdateSaturday) {
      _saturday = !_saturday;
    }
  }

  Future<void> _updateDatabase() async {
    final db = await DBProvider.db.database;
    final int id = _hours * 60 + _minutes;

    int count = await db.delete("ALARM", where: "minutes_id = "+id.toString());
    // if (count == 0) {
    await db.insert(
        "ALARM",
        Client(
          minutes_id: id,
          sunday: true,
          monday: false,
          tuesday: false,
          wednesday: true,
          thursday: true,
          friday: true,
          saturday: true,
        ).toMap());
    // }
  }

  Future<void> _showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('alarm'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iosPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'alarm',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    // ignore: deprecated_member_use
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Office',
        "alarmInfo.title",
        RepeatInterval.everyMinute,
        platformChannelSpecifics);
  }

  void dispose() {
    _alarmEventController.close();
  }
}
