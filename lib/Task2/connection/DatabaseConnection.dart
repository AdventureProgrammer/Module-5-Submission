import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'myHotel');
    var database = await openDatabase(path, version: 1, onCreate: _createTable);
    return database;
  }

  Future<void> _createTable(Database database, int version) async {
    String sql =
        'create table Hotel(id INTEGER PRIMARY KEY AUTOINCREMENT,hName TEXT,hArea TEXT,hCity TEXT, hRating TEXT)';
    await database.execute(sql);
  }
}
