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

  SleepMusicIconClient({
    @required this.musicFileIndex,
  });

  factory SleepMusicIconClient.fromMap(Map<String, dynamic> json) =>
      new SleepMusicIconClient(musicFileIndex: json["music_file_index"] as int);

  Map<String, dynamic> toMap() => {
        "music_file_index": musicFileIndex,
      };
}
