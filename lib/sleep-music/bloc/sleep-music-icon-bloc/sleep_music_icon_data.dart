import 'package:flutter/material.dart';
import 'package:Sleepify/database/database_sleep_music_icon_client.dart';
import 'package:Sleepify/database/datatbase.dart';

class SleepMusicIconData {
  Future<void> delete(
      {@required int musicTypeIndex, @required int musicFileIndex}) async {
    final db = await DBProvider.db.database;

    await db.rawDelete("DELETE FROM SLEEP_MUSIC WHERE music_type_index = " +
        musicTypeIndex.toString() +
        " AND music_file_index = " +
        musicFileIndex.toString());
  }

  Future<void> add(
      {@required int musicTypeIndex,
      @required int musicFileIndex,
      @required double volume}) async {
    final db = await DBProvider.db.database;

    await db.insert("SLEEP_MUSIC", {
      "music_type_index": musicTypeIndex,
      "music_file_index": musicFileIndex,
      "volume": volume
    });
  }

  Future<void> update(
      {@required int musicTypeIndex,
      @required int musicFileIndex,
      @required double volume}) async {
    final db = await DBProvider.db.database;
    await db.rawUpdate("UPDATE SLEEP_MUSIC SET volume = " +
        volume.toString() +
        " WHERE music_type_index = " +
        musicTypeIndex.toString() +
        " AND music_file_index = " +
        musicFileIndex.toString());
  }

  Future<List<SleepMusicIconClient>> getListOfSleepMusic() async {
    //TODO : change to dart getter if possible
    final db = await DBProvider.db.database;
    var listOfRows = await db.query("SLEEP_MUSIC");
    List<SleepMusicIconClient> listOfClients = [];
    for (Map<String, dynamic> json in listOfRows) {
      listOfClients.add(SleepMusicIconClient.fromMap(json));
    }

    return listOfClients;
  }
}
