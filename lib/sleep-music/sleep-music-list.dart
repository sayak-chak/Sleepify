import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_state.dart';
import 'package:sleep/sleep-music/sleep-music-icon.dart';
import 'package:sleep/utils/pair_for_sleep_music.dart';

class SleepMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SleepMusicIconBloc _sleepMusicIconBloc;
    _sleepMusicIconBloc = BlocProvider.of<SleepMusicIconBloc>(context);
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(
            // top: MediaQuery.of(context).size.height / 4,
            bottom: 10),
        child: GridView.count(
          padding: EdgeInsets.all(10),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: MediaQuery.of(context).size.height >
                  MediaQuery.of(context).size.width
              ? 5
              : 10,
          children: List.generate(Constants.NUMBER_OF_SLEEP_SONGS_IN_EACH_GROUP,
              (index) {
            return BlocBuilder(
                bloc: _sleepMusicIconBloc,
                builder: (BuildContext context, SleepMusicIconState state) {
                  if (state is LoadedSleepMusicFromDB) {
                    return SleepMusicIcon(
                      sleepMusicType: state.sleepMusicTypeIndex, //TODO : change
                      index: index,
                      color: state.selectedMusicIndexPairSet.contains(
                              PairForSleepMusic(
                                  musicTypeIndex: state.sleepMusicTypeIndex,
                                  musicFileIndex: index))
                          ? Colors.red
                          : Colors.white,
                    );
                  } else if (state is ChangedSleepMusicIconColor) {
                    return SleepMusicIcon(
                      sleepMusicType: state.sleepMusicTypeIndex, //TODO : change
                      index: index,
                      color: state.selectedMusicIndexPairSet.contains(
                              PairForSleepMusic(
                                  musicTypeIndex: state.sleepMusicTypeIndex,
                                  musicFileIndex: index))
                          ? Colors.red
                          : Colors.white,
                    );
                  } else if (state is UpdatedSleepMusicTypeList) {
                    return SleepMusicIcon(
                      sleepMusicType: state.sleepMusicTypeIndex, //TODO : change
                      index: index,
                      color: state.selectedMusicIndexPairSet.contains(
                              PairForSleepMusic(
                                  musicTypeIndex: state.sleepMusicTypeIndex,
                                  musicFileIndex: index))
                          ? Colors.red
                          : Colors.white,
                    );
                  }
                  return Container();
                });
          }),
        ),
      ),
    );
  }
}
