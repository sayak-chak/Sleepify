import 'dart:async';
import 'package:sleep/GLOBAL-BLOC/BOTTOM-NAV-BLOC/bottom_nav_event.dart';

class BottomNavBarBloc {
  final _globalAppEventController = StreamController<BottomNavEvent>();
  final _globalAppBottomNavBarStateController = StreamController<int>();
  // AudioPlayer _sleepMusicPlayer;

  Stream<dynamic> get appBodyIndex =>
      _globalAppBottomNavBarStateController.stream;
  Sink<BottomNavEvent> get appGlobalEventSink => _globalAppEventController.sink;
  BottomNavBarBloc() {
    _globalAppEventController.stream.listen(_mapGlobalEventToState);
  }

  void dispose() {
    _globalAppEventController.close();
    _globalAppBottomNavBarStateController.close();
  }

  Future<void> _mapGlobalEventToState(BottomNavEvent event) async {
    if (event is ChangeAppBody) {
      _globalAppBottomNavBarStateController.sink.add(event.updatedAppBodyIndex);
    }
  }
}
