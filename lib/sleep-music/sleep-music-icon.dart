import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';

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
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.redAccent,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
        color: color,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.blueAccent,
        //     spreadRadius: color == Colors.white ? 4 : 10,
        //     blurRadius: color == Colors.white ? 4 : 10,
        //   ),
        //   BoxShadow(
        //     color: Colors.blueAccent,
        //     spreadRadius: color == Colors.white ? -4 : -10,
        //     blurRadius: color == Colors.white ? 4 : 10,
        //   )
        // ],
      ),
      child: InkWell(
        onTap: () async {
          BlocProvider.of<SleepMusicIconBloc>(context).add(
            AddOrRemoveSleepMusicIcon(
              musicFileIndex: index,
              playPauseButtonBloc:
                  BlocProvider.of<PlayPauseButtonBloc>(context),
              errorBloc: BlocProvider.of<ErrorBloc>(context),
            ),
          );
        },
        child: SizedBox(
          width: 180,
          height: 180,
          child: Wrap(children: [
            Column(
              children: [
                IconButton(
                    icon: Icon(Constants.ICON_DATA_LIST[sleepMusicType][index]),
                    onPressed: () => {}),
                Center(
                  child: Text(
                    Constants.SLEEP_MUSIC_DESC[sleepMusicType][index],
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
