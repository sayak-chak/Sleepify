import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/errors/error-bloc/error_event.dart';
import 'package:sleep/errors/error-bloc/error_state.dart';
import 'package:sleep/errors/error-dialog-box.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_event.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_state.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_state.dart';
import 'package:sleep/sleep-music/sleep-music-icon.dart';

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
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              icon: BlocBuilder(
                bloc: _playPauseButtonBloc,
                builder: (BuildContext context, PlayPauseButtonState state) {
                  if (state is UpdatePlayPauseButton) {
                    return Icon(
                      state.newButton,
                      color: Colors.white,
                      size: 50,
                    );
                  }
                  return Icon(
                    FontAwesomeIcons.playCircle,
                    color: Colors.white,
                    size: 50,
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
          Spacer(),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                  // top: MediaQuery.of(context).size.height / 4,
                  bottom: 10),
              child: GridView.count(
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 5,
                children:
                    List.generate(Constants.NUMBER_OF_SLEEP_SONGS, (index) {
                  return BlocBuilder(
                      bloc: _sleepMusicIconBloc,
                      builder:
                          (BuildContext context, SleepMusicIconState state) {
                        if (state is LoadedSleepMusicFromDB) {
                          return SleepMusicIcon(
                            index: index,
                            color: state.playList.contains(index)
                                ? Colors.red
                                : Colors.white,
                          );
                        } else if (state is ChangedSleepMusicIconColor) {
                          return SleepMusicIcon(
                            index: index,
                            color: state.selectedIndexes.contains(index)
                                ? Colors.red
                                : Colors.white,
                          );
                        }
                        return Container();
                      });
                }),
              ),
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
