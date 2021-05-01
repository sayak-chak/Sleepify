import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/database/database_sleep_music_icon_client.dart';
import 'package:Sleepify/utils/pair_for_sleep_music.dart';

abstract class SleepMusicIconState {}

class LoadingState extends SleepMusicIconState {}

class LoadedSleepMusicFromDB extends SleepMusicIconState {
  final int sleepMusicTypeIndex = Constants.SLEEP_MUSIC_TYPE_NATURE;
  final HashSet<PairForSleepMusic> selectedMusicIndexPairSet;
  LoadedSleepMusicFromDB({@required this.selectedMusicIndexPairSet});
}

class ChangedSleepMusicIconColor extends SleepMusicIconState {
  final int sleepMusicTypeIndex;
  final HashSet<PairForSleepMusic> selectedMusicIndexPairSet;
  ChangedSleepMusicIconColor(
      {@required this.selectedMusicIndexPairSet,
      @required this.sleepMusicTypeIndex});
}

class UpdatedSleepMusicTypeList extends SleepMusicIconState {
  final int sleepMusicTypeIndex;
  final HashSet<PairForSleepMusic> selectedMusicIndexPairSet;
  UpdatedSleepMusicTypeList({
    @required this.sleepMusicTypeIndex,
    @required this.selectedMusicIndexPairSet,
  });
}
