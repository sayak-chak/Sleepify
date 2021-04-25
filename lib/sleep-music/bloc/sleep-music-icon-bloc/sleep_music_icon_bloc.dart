import 'dart:collection';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/database/database_sleep_music_icon_client.dart';
import 'package:sleep/errors/error-bloc/error_bloc.dart';
import 'package:sleep/errors/error-bloc/error_event.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_bloc.dart';
import 'package:sleep/sleep-music/bloc/play-pause-button-bloc/play_pause_button_event.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_data.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';
import 'package:sleep/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_state.dart';

class SleepMusicIconBloc
    extends Bloc<SleepMusicIconEvent, SleepMusicIconState> {
  HashMap<int, AudioPlayer> _playListMap;
  bool _isPlayingMusic = false;
  int _noOfSoundsCurrentlyBeingPlayed = 0;
  AudioCache _player = AudioCache();

  SleepMusicIconBloc() : super(null);

  @override
  Stream<SleepMusicIconState> mapEventToState(
      SleepMusicIconEvent event) async* {
    if (event is ChangeExistingSleepMusicIconColor) {
      yield ChangedSleepMusicIconColor(
          selectedIndexes: HashSet<int>.from(_playListMap.keys));
    } else if (event is AddOrRemoveSleepMusicIcon) {
      yield* _addIfNotInPlayListElseRemove(
          event.musicFileIndex, event.playPauseButtonBloc, event.errorBloc);
    } else if (event is LoadSleepMusicIconsFromDB) {
      yield* _loadSleepMusicIconsFromDB();
    } else if (event is PlayAllSounds) {
      await _resumeOrPlayAllSoundsThatAreNotPlaying();
    } else if (event is PauseAllSounds) {
      await _pauseAllSounds();
    }
  }

  Stream<SleepMusicIconState> _loadSleepMusicIconsFromDB() async* {
    List<SleepMusicIconClient> playList =
        await SleepMusicIconData().getPlayList();
    await _mapPlayList(playList);
    yield LoadedSleepMusicFromDB(playList: playList);
  }

  Future<void> _mapPlayList(List<SleepMusicIconClient> playList) async {
    _playListMap = HashMap();

    for (SleepMusicIconClient sleepMusicClient in playList) {
      AudioPlayer audioPlayer = await _player.loop(
          Constants.MUSIC_FILE_CORRESPONDING_TO_ICON_INDEX[
              sleepMusicClient.musicFileIndex]);
      audioPlayer.pause();
      _playListMap[sleepMusicClient.musicFileIndex] = audioPlayer;
    }
  }

  Stream<SleepMusicIconState> _addIfNotInPlayListElseRemove(int musicFileIndex,
      PlayPauseButtonBloc playPauseButtonBloc, ErrorBloc errorBloc) async* {
    if (_playListMap.containsKey(musicFileIndex)) {
      await _playListMap[musicFileIndex].stop();
      _playListMap.remove(musicFileIndex);
      yield ChangedSleepMusicIconColor(
          selectedIndexes: HashSet<int>.from(_playListMap.keys));
      //
      SleepMusicIconData().delete(musicFileIndex: musicFileIndex);
      //
      _noOfSoundsCurrentlyBeingPlayed--;
      if (_noOfSoundsCurrentlyBeingPlayed == 0) {
        _isPlayingMusic = false;
        // _globalAppSleepMusicButtonStateController.add(FontAwesomeIcons.playCircle);
        playPauseButtonBloc.add(
            HardUpdatePlayPauseButton(newButton: FontAwesomeIcons.playCircle));
      }
    } else if (_noOfSoundsCurrentlyBeingPlayed ==
        Constants.MAX_NO_OF_CONCURRENT_SOUNDS) {
      errorBloc.add(NewError(
          errorMessage: "Only " +
              Constants.MAX_NO_OF_CONCURRENT_SOUNDS.toString() +
              " sounds can be played at once"));
    } else {
      //add sound
      _noOfSoundsCurrentlyBeingPlayed++;
      SleepMusicIconData().add(musicFileIndex: musicFileIndex);
      _playListMap[musicFileIndex] = await _player.loop(
          Constants.MUSIC_FILE_CORRESPONDING_TO_ICON_INDEX[musicFileIndex]);
      _playListMap[musicFileIndex].pause();
      yield ChangedSleepMusicIconColor(
          selectedIndexes: HashSet<int>.from(_playListMap.keys));

      if (_noOfSoundsCurrentlyBeingPlayed == 1) {
        _isPlayingMusic = true;
        // _globalAppSleepMusicButtonStateController.add(FontAwesomeIcons.pauseCircle);
        _playListMap[musicFileIndex].resume();
        playPauseButtonBloc.add(
            HardUpdatePlayPauseButton(newButton: FontAwesomeIcons.pauseCircle));
        // yield UpdatePlayPauseButton(newButton: FontAwesomeIcons.pauseCircle);
      }
      if (_isPlayingMusic) {
        _resumeOrPlayAllSoundsThatAreNotPlaying();
      }
    }
  }

  Future<void> _resumeOrPlayAllSoundsThatAreNotPlaying() async {
    for (int musicFileIndex in _playListMap.keys) {
      if (_playListMap[musicFileIndex].state == AudioPlayerState.PLAYING) {
        continue;
      } else if (_playListMap[musicFileIndex].state ==
          AudioPlayerState.PAUSED) {
        await _playListMap[musicFileIndex].resume();
      } else {
        await _playListMap[musicFileIndex].play(
            Constants.MUSIC_FILE_CORRESPONDING_TO_ICON_INDEX[musicFileIndex]);
      }
    }
  }

  Future<void> _pauseAllSounds() async {
    for (int musicFileIndex in _playListMap.keys) {
      await _playListMap[musicFileIndex].pause();
    }
  }
}
