import 'dart:collection';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/database/database_sleep_music_icon_client.dart';
import 'package:Sleepify/errors/error-bloc/error_bloc.dart';
import 'package:Sleepify/errors/error-bloc/error_event.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/play-pause-button-bloc/play_pause_button_event.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_data.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_state.dart';
import 'package:Sleepify/utils/pair_for_sleep_music.dart';

class SleepMusicIconBloc
    extends Bloc<SleepMusicIconEvent, SleepMusicIconState> {
  HashMap<PairForSleepMusic, AudioPlayer> _playListMap;

  HashMap<PairForSleepMusic, double> playListVolumeMap;
  // bool _isPlayingMusic = false;
  // int _noOfSoundsCurrentlyBeingPlayed = 0;
  int _currentSleepMusicTypeIndex = Constants.SLEEP_MUSIC_TYPE_NATURE;
  AudioCache _player = AudioCache();

  SleepMusicIconBloc() : super(null);

  @override
  Stream<SleepMusicIconState> mapEventToState(
      SleepMusicIconEvent event) async* {
    if (event is ChangeExistingSleepMusicIconColor) {
      yield ChangedSleepMusicIconColor(
        selectedMusicIndexPairSet:
            HashSet<PairForSleepMusic>.from(_playListMap.keys),
        sleepMusicTypeIndex: _currentSleepMusicTypeIndex,
      );
    } else if (event is AddOrRemoveSleepMusicIcon) {
      yield* _addIfNotInPlayListElseRemove(
          event.musicFileIndex, event.playPauseButtonBloc, event.errorBloc);
    } else if (event is LoadSleepMusicIconsFromDB) {
      yield* _loadSleepMusicIconsFromDB();
    } else if (event is PlayAllSounds) {
      await _resumeOrPlayAllSoundsThatAreNotPlaying();
    } else if (event is PauseAllSounds) {
      await _pauseAllSounds();
    } else if (event is UpdateSleepMusicTypeList) {
      yield* _updateSleepMusicTypeIndex(event.sleepMusicListType);
    } else if (event is ChangeVolumeOfCurrentlyPlayingMusic) {
      _updateVolumeIfSongIsInPlayList(
          event.sleepMusicType, event.musicFileIndex, event.newVolume);
    }
  }

  void _updateVolumeIfSongIsInPlayList(
      int sleepMusicType, int musicFileIndex, double newVolume) {
    PairForSleepMusic inputSleepMusic = PairForSleepMusic(
        musicTypeIndex: sleepMusicType, musicFileIndex: musicFileIndex);
    for (PairForSleepMusic sleepMusic in _playListMap.keys) {
      if (sleepMusic == inputSleepMusic) {
        _playListMap[sleepMusic].setVolume(newVolume);
        playListVolumeMap[sleepMusic] = newVolume;
        break;
      }
    }
  }

  Stream<SleepMusicIconState> _updateSleepMusicTypeIndex(
      String sleepMusicListType) async* {
    if (sleepMusicListType == "Animals & Birds") {
      _currentSleepMusicTypeIndex = Constants.SLEEP_MUSIC_TYPE_NATURE;
    } else if (sleepMusicListType == "Nature") {
      _currentSleepMusicTypeIndex = Constants.SLEEP_MUSIC_TYPE_MECHANICAL;
    } else {
      _currentSleepMusicTypeIndex = Constants.SLEEP_MUSIC_TYPE_PLANETARY;
    }
    yield UpdatedSleepMusicTypeList(
        sleepMusicTypeIndex: _currentSleepMusicTypeIndex,
        selectedMusicIndexPairSet:
            HashSet<PairForSleepMusic>.from(_playListMap.keys));
  }

  Stream<SleepMusicIconState> _loadSleepMusicIconsFromDB() async* {
    List<SleepMusicIconClient> playList =
        await SleepMusicIconData().getPlayList();
    await _mapPlayList(playList);
    yield LoadedSleepMusicFromDB(
        selectedMusicIndexPairSet:
            HashSet<PairForSleepMusic>.from(_playListMap.keys));
  }

  Future<void> _mapPlayList(List<SleepMusicIconClient> playList) async {
    _playListMap = HashMap();
    playListVolumeMap = HashMap();

    for (SleepMusicIconClient sleepMusicClient in playList) {
      AudioPlayer audioPlayer = await _player.loop(
          Constants.MUSIC_FILE_CORRESPONDING_TO_ICON_INDEX[
              _currentSleepMusicTypeIndex][sleepMusicClient.musicFileIndex]);
      await audioPlayer.pause();
      // await audioPlayer.resume();
      _playListMap[PairForSleepMusic(
          musicTypeIndex: _currentSleepMusicTypeIndex,
          musicFileIndex: sleepMusicClient.musicFileIndex)] = audioPlayer;
    }
  }

  Stream<SleepMusicIconState> _addIfNotInPlayListElseRemove(int musicFileIndex,
      PlayPauseButtonBloc playPauseButtonBloc, ErrorBloc errorBloc) async* {
    if (_playListMap.containsKey(PairForSleepMusic(
        musicTypeIndex: _currentSleepMusicTypeIndex,
        musicFileIndex: musicFileIndex))) {
      await _playListMap[PairForSleepMusic(
              musicTypeIndex: _currentSleepMusicTypeIndex,
              musicFileIndex: musicFileIndex)]
          .stop();
      _playListMap.remove(PairForSleepMusic(
          musicTypeIndex: _currentSleepMusicTypeIndex,
          musicFileIndex: musicFileIndex));
      playListVolumeMap.remove(PairForSleepMusic(
          musicTypeIndex: _currentSleepMusicTypeIndex,
          musicFileIndex: musicFileIndex));
      yield ChangedSleepMusicIconColor(
          sleepMusicTypeIndex: _currentSleepMusicTypeIndex,
          selectedMusicIndexPairSet:
              HashSet<PairForSleepMusic>.from(_playListMap.keys));
      //
      SleepMusicIconData().delete(
          musicTypeIndex: _currentSleepMusicTypeIndex,
          musicFileIndex: musicFileIndex);
      if (_playListMap.isEmpty) {
        playPauseButtonBloc.add(
            HardUpdatePlayPauseButton(newButton: FontAwesomeIcons.playCircle));
      }
    } else if (_playListMap.length == Constants.MAX_NO_OF_CONCURRENT_SOUNDS) {
      errorBloc.add(NewError(
          errorMessage: "Only " +
              Constants.MAX_NO_OF_CONCURRENT_SOUNDS.toString() +
              " sounds can be played at once"));
    } else {
      //add sound
      // _noOfSoundsCurrentlyBeingPlayed++;
      SleepMusicIconData().add(
          musicTypeIndex: _currentSleepMusicTypeIndex,
          musicFileIndex: musicFileIndex);
      _playListMap[PairForSleepMusic(
              musicTypeIndex: _currentSleepMusicTypeIndex,
              musicFileIndex: musicFileIndex)] =
          await _player.loop(Constants.MUSIC_FILE_CORRESPONDING_TO_ICON_INDEX[
              _currentSleepMusicTypeIndex][musicFileIndex]);
      playListVolumeMap[PairForSleepMusic(
          musicTypeIndex: _currentSleepMusicTypeIndex,
          musicFileIndex: musicFileIndex)] = 0.5; //TODO : definitely refactor
      _playListMap[PairForSleepMusic(
              musicTypeIndex: _currentSleepMusicTypeIndex,
              musicFileIndex: musicFileIndex)]
          .setVolume(0.5);
      await _playListMap[PairForSleepMusic(
              musicTypeIndex: _currentSleepMusicTypeIndex,
              musicFileIndex: musicFileIndex)]
          .pause();
      yield ChangedSleepMusicIconColor(
          sleepMusicTypeIndex: _currentSleepMusicTypeIndex,
          selectedMusicIndexPairSet:
              HashSet<PairForSleepMusic>.from(_playListMap.keys));

      playPauseButtonBloc.add(
          HardUpdatePlayPauseButton(newButton: FontAwesomeIcons.pauseCircle));
      await _resumeOrPlayAllSoundsThatAreNotPlaying();
    }
  }

  Future<void> _resumeOrPlayAllSoundsThatAreNotPlaying() async {
    for (PairForSleepMusic musicFileIndexPair in _playListMap.keys) {
      if (_playListMap[musicFileIndexPair].state == AudioPlayerState.PLAYING) {
        continue;
      } else {
        if (!playListVolumeMap.containsKey(musicFileIndexPair)) {//TODO: refactor, HACKIEST FIX EVER
          playListVolumeMap[musicFileIndexPair] = 0.5;
        }
        _playListMap[musicFileIndexPair]
            .setVolume(playListVolumeMap[musicFileIndexPair]);
        await _playListMap[musicFileIndexPair].resume();
      }
    }
  }

  Future<void> _pauseAllSounds() async {
    for (PairForSleepMusic musicFileIndexPair in _playListMap.keys) {
      await _playListMap[musicFileIndexPair].pause();
    }
  }

  double getVolumeFor({int sleepMusicType, int musicFileIndex}) {
    if (_playListMap != null &&
        _playListMap.containsKey(PairForSleepMusic(
            musicTypeIndex: sleepMusicType, musicFileIndex: musicFileIndex))) {
      return playListVolumeMap[PairForSleepMusic(
          musicTypeIndex: sleepMusicType, musicFileIndex: musicFileIndex)];
    }
    return 0.5;
  }
}
