import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_events.dart';
import 'package:Sleepify/alarm/alarm-page/bloc/alarm_page_state.dart';

class AlarmPageBloc extends Bloc<AlarmPageEvent, AlarmPageState> {
  AlarmPageBloc() : super(null);

  @override
  Stream<AlarmPageState> mapEventToState(AlarmPageEvent event) async* {
    if (event is UpdateAlarmPageScreen) {
      yield UpdateAlarmScreen(screenIndex: event.screenIndex);
    }
  }
}
