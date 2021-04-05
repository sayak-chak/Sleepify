import 'dart:async';

import 'package:sleep/global_events.dart';

class GlobalBloc {
  final _globalAppEventController = StreamController<GlobalEvent>();
  final _globalAppStateController = StreamController<dynamic>();

  Stream<dynamic> get appBodyIndex => _globalAppStateController.stream;
  Sink<GlobalEvent> get appGlobalEventSink => _globalAppEventController.sink;

  GlobalBloc() {
    _globalAppEventController.stream.listen(_mapGlobalEventToState);
  }

  void dispose() {
    _globalAppEventController.close();
    _globalAppStateController.close();
  }

  void _mapGlobalEventToState(GlobalEvent event) {
    if (event is ChangeAppBody) {
      _globalAppStateController.sink.add(event.updatedAppBodyIndex);
    }
  }
}
