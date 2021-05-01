import 'package:flutter/material.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';

abstract class PlayPauseButtonEvent {}

class PausePlayingSleepMusic extends PlayPauseButtonEvent {}

class IntelligentlyUpdatePlayPauseButton extends PlayPauseButtonEvent {
  final SleepMusicIconBloc sleepMusicIconBloc;
  final ErrorBloc errorBloc;
  IntelligentlyUpdatePlayPauseButton(
      {@required this.sleepMusicIconBloc, @required this.errorBloc});
}

class HardUpdatePlayPauseButton extends PlayPauseButtonEvent {
  final IconData newButton;
  HardUpdatePlayPauseButton({@required this.newButton});
}
