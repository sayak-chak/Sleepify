import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';
import 'package:Sleepify/utils/pair_for_sleep_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeSlider extends StatefulWidget {
  final int sleepMusicType, musicFileIndex;

  VolumeSlider({
    @required this.sleepMusicType,
    @required this.musicFileIndex,
  });

  @override
  State<StatefulWidget> createState() => VolumeSliderState(
        sleepMusicType: this.sleepMusicType,
        musicFileIndex: this.musicFileIndex,
      );
}

class VolumeSliderState extends State<VolumeSlider> {
  double volume;
  final int sleepMusicType, musicFileIndex;

  VolumeSliderState({
    @required this.sleepMusicType,
    @required this.musicFileIndex,
  });
  @override
  void initState() {
    //TODO : definitely refactor
    volume = BlocProvider.of<SleepMusicIconBloc>(context).getVolumeFor(
      sleepMusicType: sleepMusicType,
      musicFileIndex: musicFileIndex,
    ) ?? 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        FontAwesomeIcons.volumeUp,
        size: 10,
        color: Colors.white,
      ),
      Flexible(
        child: Slider(
            // autofocus: true,
            value: volume,
            min: 0,
            max: 1,
            divisions: 10,
            activeColor: Colors.green,
            inactiveColor: Colors.orange,
            onChangeEnd: (double newVolume) {
              if (BlocProvider.of<SleepMusicIconBloc>(context)
                  .playListVolumeMap != null && BlocProvider.of<SleepMusicIconBloc>(context)
                  .playListVolumeMap
                  .containsKey(PairForSleepMusic(
                      musicTypeIndex: sleepMusicType,
                      musicFileIndex: musicFileIndex))) { //TODO: refactor ASAP
                BlocProvider.of<SleepMusicIconBloc>(context).add(
                    ChangeVolumeOfCurrentlyPlayingMusic(
                        sleepMusicType: sleepMusicType,
                        musicFileIndex: musicFileIndex,
                        newVolume: newVolume));
              }
            },
            onChanged: (double newVolume) {
              setState(() {
                this.volume = newVolume;
              });
            }),
      ),
    ]);
  }
}
