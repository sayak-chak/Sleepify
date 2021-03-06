import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sleepify/alarm/alarm-list/alarm-list-item.dart';
import 'package:Sleepify/alarm/alarm-list/bloc/alarm_list_bloc.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_bloc.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_events.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/database/database_alarm_client.dart';

class AlarmList extends StatelessWidget {
  final AlarmPageBloc alarmPageBloc;
  final AlarmListBloc _alarmListBloc = AlarmListBloc();
  AlarmList({@required this.alarmPageBloc});
  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      // padding: EdgeInsets.only(top: 20),
      // alignment: Alignment.center,
      child: Column(children: [
        Flexible(
          child: Container(
            child: FutureBuilder(
              builder: (context, alarmListSnap) {
                if (alarmListSnap.connectionState == ConnectionState.none &&
                    alarmListSnap.hasData == null) {
                  //reading from DB
                  return Container();
                }
                if (alarmListSnap.data == null ||
                    !alarmListSnap.hasData ||
                    alarmListSnap.data.length == 0) {
                  return Container();
                }
                return Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: CupertinoScrollbar(
                    isAlwaysShown: true,
                    thickness: 12,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 0,
                        // maxHeight: (MediaQuery.of(context).size.height * 3) / 4,
                      ),
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: alarmListSnap.data != null
                            ? alarmListSnap.data.length
                            : 0,
                        itemBuilder: (context, index) {
                          AlarmListItem alarm = alarmListSnap.data[index];
                          return alarm;
                        },
                      ),
                    ),
                  ),
                );
              },
              future: _getListOfAlarms(),
            ),
          ),
        ),
        Center(
          child: TextButton(
            // style: TextButton.styleFrom(
            //   shadowColor: Colors.white,
            //   primary: Colors.purple,
            //   backgroundColor: Colors.white,
            //   textStyle: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            // ),
            child: Icon(
              FontAwesomeIcons.plusCircle,
              color: Colors.white,
              size: 60,
            ),
            onPressed: () => alarmPageBloc.add(
              UpdateAlarmPageScreen(
                  screenIndex: Constants.ALARM_PAGE_ALARM_TIME_PICKER_INDEX),
            ),
          ),
        ),
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
