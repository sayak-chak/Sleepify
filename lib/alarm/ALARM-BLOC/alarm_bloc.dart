import 'dart:async';
import 'package:sleep/alarm/ALARM-BLOC/alarm_events.dart';

class AlarmBloc {
  final _alarmEventController = StreamController<AlarmEvent>();
  final _alarmStateController = StreamController<int>();

  Sink<AlarmEvent> get eventSink => _alarmEventController.sink;
  Stream<int> get stateStream => _alarmStateController.stream;
  AlarmBloc() {
    _alarmEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(AlarmEvent event) {
    if (event is UpdateAlarmPageScreen) {
      _alarmStateController.sink.add(event.screenIndex);
    }
  }

  void dispose() {
    _alarmEventController.close();
    _alarmStateController.close();
  }
}
