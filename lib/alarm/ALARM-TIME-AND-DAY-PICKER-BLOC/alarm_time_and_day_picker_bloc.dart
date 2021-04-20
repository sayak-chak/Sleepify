import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep/alarm/ALARM-BLOC/alarm_events.dart';
import 'package:sleep/alarm/ALARM-DATA/alarm-data.dart';
import 'package:sleep/alarm/ALARM-TIME-AND-DAY-PICKER-BLOC/alarm_time_and_day_picker_event.dart';
import 'package:sleep/database/database_alarm_client.dart';
import 'package:sleep/database/datatbase.dart';

class AlarmTimeAndDayPickerBloc {
  AlarmData _alarmData;
  int _hours, _minutes;
  bool _sunday, _monday, _tuesday, _wednesday, _thursday, _friday, _saturday;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _alarmTimeAndDayEventController =
      StreamController<AlarmTimeAndDayPickerEvent>();

  Sink<AlarmTimeAndDayPickerEvent> get eventSink =>
      _alarmTimeAndDayEventController.sink;

  void _initializeWithDefaultValues() {
    _hours = 0;
    _minutes = 0;
    _sunday = false;
    _monday = false;
    _tuesday = false;
    _wednesday = false;
    _thursday = false;
    _friday = false;
    _saturday = false;
  }

  AlarmTimeAndDayPickerBloc() {
    _alarmData = AlarmData();
    _initializeWithDefaultValues();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    _flutterLocalNotificationsPlugin.initialize(
      initSetttings,
    );
    _alarmTimeAndDayEventController.stream.listen(_mapEventsToState);
  }

  Future<void> _mapEventsToState(event) async {
    if (event is SetAlarm) {
      // _showNotificationMediaStyle();
      await _updateDatabase();
    } else if (event is SetHours) {
      _hours = event.hours;
    } else if (event is SetMinutes) {
      _minutes = event.minutes;
    } else if (event is SetToSunday) {
      _sunday = !_sunday;
    } else if (event is SetToMonday) {
      _monday = !_monday;
    } else if (event is SetToTuesday) {
      _tuesday = !_tuesday;
    } else if (event is SetToWednesday) {
      _wednesday = !_wednesday;
    } else if (event is SetToThursday) {
      _thursday = !_thursday;
    } else if (event is SetToFriday) {
      _friday = !_friday;
    } else if (event is SetToSaturday) {
      _saturday = !_saturday;
    }
  }

  Future<void> _updateDatabase() async {
    int id = _hours * 60 + _minutes;
    await _alarmData.upsert(
        minutesId: id,
        sunday: _sunday,
        monday: _monday,
        tuesday: _tuesday,
        wednesday: _wednesday,
        thursday: _thursday,
        friday: _friday,
        saturday: _saturday);
    _initializeWithDefaultValues();
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
    _alarmTimeAndDayEventController.close();
    // _alarmStateController.close();
  }
}
