import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_bloc.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_events.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_data.dart';
import 'package:Sleepify/alarm/alarm-page/time_zone.dart';
import 'package:Sleepify/alarm/alarm-time-and-day-picker/bloc/alarm_time_and_day_picker_event.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmTimeAndDayPickerBloc extends Bloc<AlarmTimeAndDayPickerEvent, void> {
  AlarmPageBloc alarmPageBloc;
  AlarmData _alarmData;
  int _hours, _minutes;
  bool _sunday, _monday, _tuesday, _wednesday, _thursday, _friday, _saturday;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

  AlarmTimeAndDayPickerBloc({@required this.alarmPageBloc}) : super(null) {
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

  Future<tz.TZDateTime> _nextInstanceOfAllowedDayAndTime() async {
    HashSet<int> allowedDays = HashSet<int>();
    if (_sunday) allowedDays.add(DateTime.sunday);
    if (_monday) allowedDays.add(DateTime.monday);
    if (_tuesday) allowedDays.add(DateTime.tuesday);
    if (_wednesday) allowedDays.add(DateTime.wednesday);
    if (_thursday) allowedDays.add(DateTime.thursday);
    if (_friday) allowedDays.add(DateTime.friday);
    if (_saturday) allowedDays.add(DateTime.saturday);

    tz.TZDateTime scheduledDate = await _nextInstanceOfAllowedTime();
    while (!allowedDays.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<tz.TZDateTime> _nextInstanceOfAllowedTime() async {
    final timeZone = TimeZone();
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);

    tz.setLocalLocation(tz.getLocation(timeZoneName));
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, _hours, _minutes);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _showNotificationMediaStyle() async {
    int id = _minutes + _hours * 60;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('alarm'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      additionalFlags: Int32List.fromList(<int>[4]),
      importance: Importance.max,
      playSound: true,
    );
    var iosPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'alarm',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    FlutterLocalNotificationsPlugin()
        .cancel(id); //cancelling just in case there already exits one
    tz.TZDateTime scheduledDate = await _nextInstanceOfAllowedDayAndTime();
    _flutterLocalNotificationsPlugin.zonedSchedule(
        id, "", "Alarm!", scheduledDate, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  @override
  //TODO: can this be done in a better way?
  // ignore: missing_return
  Stream<void> mapEventToState(AlarmTimeAndDayPickerEvent event) {
    if (event is SetAlarm) {
      if ((_sunday ||
          _monday ||
          _tuesday ||
          _wednesday ||
          _thursday ||
          _friday ||
          _saturday)) {
        _showNotificationMediaStyle();
        _updateDatabase();
        event.alarmPageBloc.add(UpdateAlarmPageScreen(
            screenIndex: Constants.ALARM_PAGE_ALARM_LIST_INDEX));
      } else {
        event.errorBloc.add(NewError(errorMessage: "Please select a day"));
      }
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
}
