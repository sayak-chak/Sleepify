import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:Sleepify/errors/error-bloc/error_state.dart';
import 'package:Sleepify/errors/error-dialog-box.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_event.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_state.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_state.dart';
import 'package:Sleepify/sleep-music/sleep-music-icon.dart';
import 'package:Sleepify/sleep-music/sleep-music-list.dart';
import 'package:Sleepify/sleep-music/sleep-music-list-picker.dart';

class SleepMusic extends StatelessWidget {
  final player = AudioCache();
  PlayPauseButtonBloc _playPauseButtonBloc;
  SleepMusicIconBloc _sleepMusicIconBloc;
  ErrorBloc _errorBloc;
  @override
  Widget build(BuildContext context) {
    _playPauseButtonBloc = BlocProvider.of<PlayPauseButtonBloc>(context);
    _sleepMusicIconBloc = BlocProvider.of<SleepMusicIconBloc>(context);
    _errorBloc = BlocProvider.of<ErrorBloc>(context);
    return Stack(children: [
      Column(
        children: [
          SleepMusicListPickers(),
          SleepMusicList(),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextButton(
              child: BlocBuilder(
                bloc: _playPauseButtonBloc,
                builder: (BuildContext context, PlayPauseButtonState state) {
                  if (state is UpdatePlayPauseButton) {
                    return Icon(
                      state.newButton,
                      color: Colors.white,
                      size: 60,
                    );
                  }
                  return Icon(
                    FontAwesomeIcons.playCircle,
                    color: Colors.white,
                    size: 60,
                  );
                },
              ),
              onPressed: () {
                _playPauseButtonBloc.add(IntelligentlyUpdatePlayPauseButton(
                    errorBloc: _errorBloc,
                    sleepMusicIconBloc: _sleepMusicIconBloc));
              },
            ),
          ),
        ],
      ),
      BlocBuilder(
        bloc: _errorBloc,
        builder: (BuildContext context, ErrorState state) {
          if (state is DisplayError) {
            Timer(Duration(seconds: 1), () {
              _errorBloc.add(RemoveError());
            });
            return ErrorDialog(errorMessage: state.errorMessage);
          }
          return Container();
        },
      ),
    ]);
  }
}
