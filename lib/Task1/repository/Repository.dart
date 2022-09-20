
import 'package:module_five/Task1/connection/connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late Connection _databaseConnection;
  static Database? _database;
  Repository() {
    _databaseConnection = Connection();
  }

  Future<Database?> get database async {
    if (_database != null) {
      return  _database;
    } else {
      return await _databaseConnection.setDatabase();
    }
  }

  insertData(table, values) async {
    var db = await database;
    return await db?.insert(table, values);
  }

  deleteSpecificData(table, itemid) async {
    var db = await database;
    return await db?.rawDelete(
      'delete from $table where id = $itemid',
    );
  }

  updateData(table, values) async {
    var db = await database;
    return await db
        ?.update(table, values, where: 'id=?', whereArgs: [values['id']]);
  }

  dispData(table) async {
    var db = await database;
    return await db?.query(table);
  }
}
