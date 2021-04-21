import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep/bottom-nav-bar/bloc/bottom_nav_event.dart';

class BottomNavBarBloc extends Bloc<BottomNavEvent, int> {
  BottomNavBarBloc() : super(null);

  @override
  Stream<int> mapEventToState(BottomNavEvent event) async* {
    if (event is ChangeAppBody) {
      yield event.updatedAppBodyIndex;
    }
  }
}
