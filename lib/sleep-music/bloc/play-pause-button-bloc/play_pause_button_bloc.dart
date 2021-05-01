import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sleepify/database/database_sleep_music_icon_client.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_event.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_state.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_data.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';

class PlayPauseButtonBloc
    extends Bloc<PlayPauseButtonEvent, PlayPauseButtonState> {
  IconData currentButton = FontAwesomeIcons.playCircle;

  PlayPauseButtonBloc() : super(null);
  PlayPauseButtonState get initialState => LoadingState();

  @override
  Stream<PlayPauseButtonState> mapEventToState(
      PlayPauseButtonEvent event) async* {
    if (event is IntelligentlyUpdatePlayPauseButton) {
      yield* _changeMusicButton(event.sleepMusicIconBloc, event.errorBloc);
    } else if (event is HardUpdatePlayPauseButton) {
      currentButton = event.newButton;
      yield UpdatePlayPauseButton(newButton: this.currentButton);
    }
  }

  Stream<PlayPauseButtonState> _changeMusicButton(
      SleepMusicIconBloc sleepMusicIconBloc, ErrorBloc errorBloc) async* {
    if (currentButton == FontAwesomeIcons.playCircle) {
      List<SleepMusicIconClient> playList =
          await SleepMusicIconData().getPlayList();
      if (playList == null || playList.length == 0) {
        errorBloc.add(NewError(errorMessage: "Please select a sound to play"));
      } else {
        sleepMusicIconBloc.add(PlayAllSounds());
        currentButton = FontAwesomeIcons.pauseCircle;
        yield UpdatePlayPauseButton(newButton: this.currentButton);
      }
    } else {
      sleepMusicIconBloc.add(PauseAllSounds());
      currentButton = FontAwesomeIcons.playCircle;
      yield UpdatePlayPauseButton(newButton: this.currentButton);
    }
  }
}
