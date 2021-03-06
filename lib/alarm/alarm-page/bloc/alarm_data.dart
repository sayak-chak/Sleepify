import 'package:flutter/material.dart';
import 'package:Sleepify/database/database_alarm_client.dart';
import 'package:Sleepify/database/datatbase.dart';

class AlarmData {
  Future<List<AlarmClient>> getListOfAlarms() async {
    //TODO : change to dart getter if possible
    final db = await DBProvider.db.database;
    var listOfRows = await db.query("ALARM");
    List<AlarmClient> listOfClients = [];
    for (Map<String, dynamic> json in listOfRows) {
      listOfClients.add(AlarmClient.fromMap(json));
    }
    listOfClients.sort((firstClient, secondClient) =>
        firstClient.minutes_id - secondClient.minutes_id);

    return listOfClients;
  }

  Future<void> upsert(
      {@required int minutesId,
      @required bool sunday,
      @required bool monday,
      @required bool tuesday,
      @required bool wednesday,
      @required bool thursday,
      @required bool friday,
      @required bool saturday}) async {
    await delete(minutesId: minutesId);
    final db = await DBProvider.db.database;
    await db.insert(
        "ALARM",
        AlarmClient(
          minutes_id: minutesId,
          sunday: sunday,
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
        ).toMap());
  }

  Future<void> delete({@required int minutesId}) async {
    final db = await DBProvider.db.database;

    await db.delete("ALARM", where: "minutes_id = " + minutesId.toString());
  }
}
