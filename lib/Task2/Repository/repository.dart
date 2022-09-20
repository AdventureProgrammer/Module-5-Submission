import 'package:module_five/Task2/connection/DatabaseConnection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _connection;
  static Database? _database;
  Repository() {
    _connection = DatabaseConnection();
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _connection.setDatabase();
      return _database;
    }
  }

  insertData(table, values) async {
    var db = await database;
    return await db?.insert(table, values);
  }

  readData(table) async {
    var db = await database;
    return await db?.query(table);
  }

  updateData(table, values) async {
    var db = await database;
    return await db?.update(table, values,where: 'id=?',whereArgs: [values['id']]);
  }

  deleteData(table, hotelId) async {
    var db = await database;
    return await db?.rawDelete('delete from $table where id = $hotelId');
  }
}
