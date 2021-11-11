


import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const _dbname = 'Rooms.db';
  static const _dbVersion = 1;
  static const _tableName = 'MyUsers';
  static const columnId = '_id';
  static const columnName = 'id_Name';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async{
    if(_database!=null) {
      return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }
  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbname);
    return await openDatabase(path, version: _dbVersion,onCreate: _onCreate);

  }
  Future<dynamic>_onCreate(Database db, int version) async {
    db.execute(
        '''
      CREATE TABLE $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL)
      '''
    );
  }
  Future<int> insert(Map<String,dynamic>row) async{
    Database? db = await instance.database;
    return await db!.insert(_tableName, row);
  }
  Future<List<Map<String,dynamic>>>queryAll()async{
    Database? db = await instance.database;
    return await db!.query(_tableName);
  }
  Future<List<Map<String,dynamic>>>querySome(String name)async{
    Database? db = await instance.database;
    return await db!.query(_tableName, columns: [columnId],where:'${DatabaseHelper.columnName} = ?',whereArgs: [name]);
  }
  Future<int>update(Map<String,dynamic> row) async{
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);

  }
  Future<int> delete(int id)async{
    Database? db = await instance.database;
    print('id deleted successfully'); // debug print
    return await db!.delete(_tableName,where: '$columnId = ?', whereArgs: [id]);
  }




  Future<dynamic>dropTable(String tableName)async{
    print('table deleted successfully'); //debug print
    Database? db = await instance.database;
    return await db!.rawQuery('DROP TABLE $tableName');
  }
}