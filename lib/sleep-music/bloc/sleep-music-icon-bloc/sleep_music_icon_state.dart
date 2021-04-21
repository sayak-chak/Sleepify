import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sleep/database/database_sleep_music_icon_client.dart';

abstract class SleepMusicIconState {}

class LoadingState extends SleepMusicIconState {}

class LoadedSleepMusicFromDB extends SleepMusicIconState {
  final List<SleepMusicIconClient> playList;
  LoadedSleepMusicFromDB({@required this.playList});
}

class ChangedSleepMusicIconColor extends SleepMusicIconState {
  final HashSet<int> selectedIndexes;
  ChangedSleepMusicIconColor({@required this.selectedIndexes});
}
