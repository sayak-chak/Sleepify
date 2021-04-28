import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PairForSleepMusic extends Equatable {
  final int musicTypeIndex;
  final int musicFileIndex;
  PairForSleepMusic({@required this.musicTypeIndex, @required this.musicFileIndex});

  @override
  List<Object> get props => [musicTypeIndex, musicFileIndex];
}
