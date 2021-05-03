/// ClientModel.dart
import 'dart:convert';

import 'package:flutter/material.dart';

SleepMusicIconClient clientFromJson(String str) {
  final jsonData = json.decode(str);
  return SleepMusicIconClient.fromMap(jsonData);
}

String clientToJson(SleepMusicIconClient data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class SleepMusicIconClient {
  int musicFileIndex;
  int musicTypeIndex;
  double volume;

  SleepMusicIconClient(
      {@required this.musicTypeIndex,
      @required this.musicFileIndex,
      @required this.volume});

  factory SleepMusicIconClient.fromMap(Map<String, dynamic> json) =>
      new SleepMusicIconClient(
        musicTypeIndex: json["music_type_index"] as int,
        musicFileIndex: json["music_file_index"] as int,
        volume: json["volume"] as double,
      );

  Map<String, dynamic> toMap() => {
        "music_type_index": musicTypeIndex,
        "music_file_index": musicFileIndex,
        "volume": volume,
      };
}
