import 'dart:async';

import 'package:sleep/alarm-page/alarm_events.dart';
import 'package:sleep/alarm-page/alarm_time.dart';

class AlarmBloc {
  List<AlarmTime> _alarmList = [];
  final _alarmStateController = StreamController<List<AlarmTime>>();
  final _alarmEventController = StreamController<AlarmEvent>();

  Stream<List<AlarmTime>> get alarmList => _alarmStateController.stream;
  Sink<AlarmEvent> get alarmEventSink => _alarmEventController.sink;

  AlarmBloc() {
    _alarmEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(AlarmEvent event) {
    if (event is AddAlarm) {
      _alarmList.add(event.alarmTime);
    }
    _alarmStateController.sink.add(_alarmList);
  }
}
