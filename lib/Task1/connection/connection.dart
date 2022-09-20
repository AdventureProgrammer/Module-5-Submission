import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class Connection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'myTask6');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreateTable);
    return database;
  }

  Future<void> _onCreateTable(Database db, int version) async {
    String tableQuery =
        'create table task(id INTEGER PRIMARY KEY AUTOINCREMENT,taskname TEXT,description TEXT,date TEXT,time TEXT,priority TEXT,taskstatus TEXT)';
    await db.execute(tableQuery);
  }
}
