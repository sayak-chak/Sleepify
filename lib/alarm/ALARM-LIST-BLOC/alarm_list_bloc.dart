import 'package:sleep/alarm/ALARM-DATA/alarm-data.dart';
import 'package:sleep/database/database_alarm_client.dart';

class AlarmListBloc {
  AlarmData _alarmData;
  AlarmListBloc() {
    _alarmData = AlarmData();
  }

  Future<List<AlarmClient>> get listOfAlarmClients => _alarmData.getListOfAlarms();

  Future<void> cancelAlarm({int id}) async {
    await _alarmData.delete(minutesId: id);
  }

  void dispose() {
    //for extensibility
  }
}
