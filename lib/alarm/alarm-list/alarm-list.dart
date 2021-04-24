import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/alarm/alarm-list/alarm-list-item.dart';
import 'package:sleep/alarm/alarm-list/bloc/alarm_list_bloc.dart';
import 'package:sleep/alarm/alarm-page/bloc/alarm_page_bloc.dart';
import 'package:sleep/alarm/alarm-page/bloc/alarm_page_events.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/database/database_alarm_client.dart';

class AlarmList extends StatelessWidget {
  final AlarmPageBloc alarmPageBloc;
  final AlarmListBloc _alarmListBloc = AlarmListBloc();
  AlarmList({@required this.alarmPageBloc});
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
                onPressed: () => alarmPageBloc.add(UpdateAlarmPageScreen(
                    screenIndex:
                        Constants.ALARM_PAGE_ALARM_TIME_PICKER_INDEX))),
          ),
        )
      ]),
    );
  }

  Future<List<AlarmListItem>> _getListOfAlarms() async {
    List<AlarmListItem> listOfAlarms = [];
    List<AlarmClient> listOfClients = await _alarmListBloc.listOfAlarmClients;
    for (AlarmClient alarm in listOfClients) {
      listOfAlarms.add(AlarmListItem(
        alarmListBloc: _alarmListBloc,
        alarmPageBloc: alarmPageBloc,
        hh: alarm.minutes_id ~/ 60,
        mm: alarm.minutes_id % 60,
        sunday: alarm.sunday,
        monday: alarm.monday,
        tuesday: alarm.tuesday,
        wednesday: alarm.wednesday,
        thursday: alarm.thursday,
        friday: alarm.friday,
        saturday: alarm.saturday,
      ));
    }
    return listOfAlarms;
  }
}
