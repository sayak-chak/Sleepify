import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/alarm-page/alarm-list-item.dart';
import 'package:sleep/alarm-page/alarm_bloc.dart';
import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/alarm-page/cancel-or-save.dart';
import 'package:sleep/alarm-page/alarm-time-picker.dart';
import 'package:sleep/alarm-page/week-day-picker.dart';
import 'package:sleep/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sleep/database-client.dart';
import 'package:sleep/datatbase.dart';
import 'package:sleep/global_events.dart';
import 'package:sleep/main.dart';

class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  AlarmBloc _alarmBloc;

  @override
  void initState() {
    _alarmBloc = AlarmBloc();
    super.initState();
  }

  @override
  void dispose() {
    _alarmBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: FutureBuilder(
            builder: (context, alarmListSnap) {
              if (alarmListSnap.connectionState == ConnectionState.none &&
                  alarmListSnap.hasData == null) {
                //reading from DB
                return Container();
              }
              return ListView.builder(
                itemCount:
                    alarmListSnap.data != null ? alarmListSnap.data.length : 0,
                itemBuilder: (context, index) {
                  AlarmListItem alarm = alarmListSnap.data[index];
                  return alarm;
                },
              );
            },
            future: _getListOfAlarms(),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                  side: MaterialStateProperty.all(
                    BorderSide(width: 3),
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AlarmTimePicker(),
                    ),
                  );
                }),
          ),
        )
      ]),
    );
  }

  Future<List<AlarmListItem>> _getListOfAlarms() async {
    List<AlarmListItem> listOfAlarms = [];
    final db = await DBProvider.db.database;
    var x = await db.query("ALARM");
    List<Client> listOfClients = [];
    for (Map<String, dynamic> json in x) {
      listOfClients.add(Client.fromMap(json));
    }
    listOfClients.sort((firstClient, secondClient) =>
        firstClient.minutes_id - secondClient.minutes_id);

    for (Client alarm in listOfClients) {
      listOfAlarms.add(AlarmListItem(
        hh: alarm.minutes_id ~/ 60,
        mm: alarm.minutes_id % 60,
        alarmBloc: _alarmBloc,
        sunday: alarm.sunday,
        monday: alarm.monday,
        tuesday: alarm.tuesday,
        wednesday: alarm.wednesday,
        thursday: alarm.thursday,
        friday: alarm.friday,
        saturday: alarm.saturday,
      ));
    }
  }
}
