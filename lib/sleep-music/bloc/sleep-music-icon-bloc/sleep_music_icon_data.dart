import 'package:flutter/material.dart';
import 'package:sleep/database/database_sleep_music_icon_client.dart';
import 'package:sleep/database/datatbase.dart';

class SleepMusicIconData {
  Future<List<SleepMusicIconClient>> getPlayList() async {
    //TODO : change to dart getter if possible
    final db = await DBProvider.db.database;
    var listOfRows = await db.query("SLEEP_MUSIC");
    List<SleepMusicIconClient> listOfClients = [];

    for (Map<String, dynamic> json in listOfRows) {
      listOfClients.add(SleepMusicIconClient.fromMap(json));
    }

    return listOfClients;
  }

  Future<void> delete({@required int musicFileIndex}) async {
    final db = await DBProvider.db.database;

    await db.delete("SLEEP_MUSIC",
        where: "music_file_index = " + musicFileIndex.toString());
  }

  Future<void> add({@required int musicFileIndex}) async {
    final db = await DBProvider.db.database;

    await db.insert("SLEEP_MUSIC", {"music_file_index": musicFileIndex});
  }
}
