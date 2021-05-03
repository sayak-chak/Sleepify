import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SleepifyPair extends Equatable {
  final firstElement;
  final secondElement;
  SleepifyPair({@required this.firstElement, @required this.secondElement});

  @override
  List<Object> get props => [firstElement, secondElement];
}

class PairForSleepMusicFile extends SleepifyPair {
  final int musicTypeIndex;
  final int musicFileIndex;
  PairForSleepMusicFile(
      {@required this.musicTypeIndex, @required this.musicFileIndex})
      : super(firstElement: musicTypeIndex, secondElement: musicFileIndex);
}

// ignore: must_be_immutable
class PairForSleepMusicPlayerAndVolume extends SleepifyPair {
  final AudioPlayer audioPlayer;
  double volume;
  PairForSleepMusicPlayerAndVolume(
      {@required this.audioPlayer, @required this.volume})
      : super(firstElement: audioPlayer, secondElement: volume);
}
