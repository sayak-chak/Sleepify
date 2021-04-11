import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  //Singleton pattern - single instance globally, that would be reused
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "SleepAppDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ALARM ("
          "minutes_id INTEGER PRIMARY KEY,"
          "sunday BIT,"
          "monday BIT,"
          "tuesday BIT,"
          "wednesday BIT,"
          "thursday BIT,"
          "friday BIT,"
          "saturday BIT"
          ")");
    });
  }
}
