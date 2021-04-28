import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';

class SleepMusicIcon extends StatelessWidget {
  final int index;
  final int sleepMusicType;
  final Color color;
  SleepMusicIcon({
    @required this.index,
    @required this.color,
    @required this.sleepMusicType,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.all(
        //   Radius.circular(18.0),
        // ),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent,
            spreadRadius: color == Colors.white ? 4 : 10,
            blurRadius: color == Colors.white ? 4 : 10,
          ),
          BoxShadow(
            color: Colors.blueAccent,
            spreadRadius: color == Colors.white ? -4 : -10,
            blurRadius: color == Colors.white ? 4 : 10,
          )
        ],
      ),
      child: IconButton(
        icon: Icon(Constants.ICON_DATA_LIST[sleepMusicType][index]),
        onPressed: () async {
          BlocProvider.of<SleepMusicIconBloc>(context).add(
            AddOrRemoveSleepMusicIcon(
              musicFileIndex: index,
              playPauseButtonBloc:
                  BlocProvider.of<PlayPauseButtonBloc>(context),
              errorBloc: BlocProvider.of<ErrorBloc>(context),
            ),
          );
        },
      ),
    );
  }
}
