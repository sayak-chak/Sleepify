import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/global_events.dart';
import 'package:sleep/alarm-page/alarm-page.dart';

class AlarmBloc {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _alarmEventController = StreamController<AlarmEvent>();
  // final _alarmStateController = StreamController<dynamic>();

  Sink<AlarmEvent> get addAlarm => _alarmEventController.sink;

  AlarmBloc() {
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
      _showNotificationMediaStyle();
    }
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
