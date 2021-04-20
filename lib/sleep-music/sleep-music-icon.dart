import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';

class SleepMusicIcon extends StatelessWidget {
  final int index;
  final Color color;
  SleepMusicIcon({@required this.index, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: color,
      child: Column(children: [
        IconButton(
          icon: Icon(Constants.ICON_DATA_LIST[index]),
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
      ]),
    );
  }
}
