import 'package:flutter/material.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';

abstract class SleepMusicIconEvent {}

class LoadSleepMusicIconsFromDB extends SleepMusicIconEvent {}

class AddOrRemoveSleepMusicIcon extends SleepMusicIconEvent {
  final int musicFileIndex;
  final PlayPauseButtonBloc playPauseButtonBloc;
  final ErrorBloc errorBloc;
  AddOrRemoveSleepMusicIcon(
      {@required this.musicFileIndex,
      @required this.playPauseButtonBloc,
      this.errorBloc});
}

class ChangeExistingSleepMusicIconColor extends SleepMusicIconEvent {
  final int iconIndex;
  final Color currentColor;
  ChangeExistingSleepMusicIconColor(
      {@required this.iconIndex, @required this.currentColor});
}

class PlayAllSounds extends SleepMusicIconEvent {}

class PauseAllSounds extends SleepMusicIconEvent {}

class UpdateSleepMusicTypeList extends SleepMusicIconEvent {
  final String sleepMusicListType;
  UpdateSleepMusicTypeList({@required this.sleepMusicListType});
}
