import 'package:Sleepify/errors/error-bloc/error_state.dart';
import 'package:Sleepify/sleep-music/volume-slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';

class SleepMusicIcon extends StatefulWidget {
  final int index;
  final int sleepMusicType;
  final Color color;
  SleepMusicIcon({
    @required this.index,
    @required this.color,
    @required this.sleepMusicType,
  }) : super(key: UniqueKey());

  @override
  StateOfSleepMusicIcon createState() {
    return StateOfSleepMusicIcon(
      color: color,
      index: index,
      sleepMusicType: sleepMusicType,
    );
  }
}

class StateOfSleepMusicIcon extends State<SleepMusicIcon> {
  //weird name to fix import conflict
  final int index;
  final int sleepMusicType;
  Color color;
  StateOfSleepMusicIcon({
    @required this.index,
    @required this.color,
    @required this.sleepMusicType,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      // padding: EdgeInsets.all(3),
      // color: Colors.red,
      child: InkWell(
        focusColor: Colors.red,
        onTap: () async {
          BlocProvider.of<SleepMusicIconBloc>(context).add(
            AddOrRemoveSleepMusicIcon(
              musicFileIndex: index,
              playPauseButtonBloc:
                  BlocProvider.of<PlayPauseButtonBloc>(context),
              errorBloc: BlocProvider.of<ErrorBloc>(context),
            ),
          );
          if (!(BlocProvider.of<ErrorBloc>(context).state is ErrorState)) {
            setState(() {
              color = color == Colors.red ? Colors.white : Colors.red;
            });
          }
          //     BlocBuilder(
          //   bloc: BlocProvider.of<ErrorBloc>(context).,
          //   builder: (BuildContext context, ErrorState state) {
          //     if (!(state is DisplayError)) {
          //       setState(() {
          //       color = color == Colors.red ? Colors.white : Colors.red;
          //     });
          //     }
          //   },
          // )
        },
        child: Container(
          decoration: color == Colors.white
              ? null
              : BoxDecoration(
                  border: Border.all(
                    color: Colors.redAccent,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(14.0),
                  ),
                  // color: color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      // spreadRadius: 10,
                      // blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black87,
                      // spreadRadius: -10,
                      // blurRadius: 10,
                    )
                  ],
                ),
          child: Column(
            children: [
              VolumeSlider(
                sleepMusicType: sleepMusicType,
                musicFileIndex: index,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Wrap(children: [
                    Column(
                      children: [
                        Center(
                          child: IconButton(
                              icon: Icon(
                                Constants.ICON_DATA_LIST[sleepMusicType][index],
                                color: color,
                              ),
                              onPressed: () => {}),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Flexible(
                child: Center(
                  child: Text(
                    Constants.SLEEP_MUSIC_DESC[sleepMusicType][index],
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
