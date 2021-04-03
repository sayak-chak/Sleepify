import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sleep/utils/button.dart';
import 'package:sleep/utils/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep/main.dart';

class PowerNap extends StatefulWidget {
  @override
  State<PowerNap> createState() {
    return _PowerNapState();
  }
}

class _PowerNapState extends State<PowerNap> {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  String val = 'One';
  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload,
      );
    }));
  }

  // void initState() {
  //   super.initState();
  //   var initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettingsIOs = IOSInitializationSettings();
  //   var initSetttings = InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

  //   flutterLocalNotificationsPlugin.initialize(initSetttings,
  //       onSelectNotification: onSelectNotification);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(255, 255, 255, 0),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 4,
          bottom: MediaQuery.of(context).size.height / 4,
          left: 30,
          right: 30,
        ),
        // color: Color.fromRGBO(0, 0, 0, 0),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
        child: ListView(
          children: [
            Button(
              buttonTitle: "5 minutes",
              onPressed: showNotificationMediaStyle,
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Button(
              buttonTitle: "10 minutes",
              onPressed: () {},
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Button(
              buttonTitle: "15 minutes",
              onPressed: () {},
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Button(
              buttonTitle: "20 minutes",
              onPressed: () {},
              buttonColor: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
              fontSize: Constants.MEDIUM_SIZE,
            ),
            Row(
              children: [
                Expanded(
                    child: Button(
                  buttonTitle: "✔",
                  onPressed: () {},
                  buttonColor: Constants.DEFAULT_RIGHT_COLOR,
                  fontSize: Constants.LARGE_SIZE,
                )),
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    child: Button(
                  buttonTitle: "✘",
                  onPressed: () {},
                  buttonColor: Constants.DEFAULT_WRONG_COLOR,
                  fontSize: Constants.LARGE_SIZE,
                )),
              ],
            )
          ],
        ));
  }

  showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // ignore: deprecated_member_use //TODO: refactor
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> showNotificationMediaStyle() async {
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     .createNotificationChannel(const AndroidNotificationChannel(
    //       '1',
    //       '1',
    //       '1',
    //       // groupId: channelGroupId
    //     ));
    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //     '1',
    //     'flutterfcm',
    //     'flutterfcm',
    //     icon: '@mipmap/ic_launcher',
    //     playSound: true,
    //     sound: RawResourceAndroidNotificationSound('alarm'),
    //     enableLights: true,
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     color: const Color.fromARGB(255, 255, 0, 0),
    //     ledColor: const Color.fromARGB(255, 255, 0, 0),
    //     ledOnMs: 1000,
    //     ledOffMs: 500);
    // var platformChannelSpecifics = NotificationDetails(
    //     android: androidPlatformChannelSpecifics, iOS: null);
    // await flutterLocalNotificationsPlugin.show(
    //     0, 'notification title', 'notification body', platformChannelSpecifics);
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
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Office',
        "alarmInfo.title",
        DateTime.now().add(Duration(seconds: 5)),
        platformChannelSpecifics);
  }
}

class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}
