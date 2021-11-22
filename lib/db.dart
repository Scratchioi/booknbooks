


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
  static const columnName = 'userName';
  static const columnBook = 'book';
  static const columnEmail = 'email';
  static const columnPage = 'pageNumber';
  static const columnISBN = 'isbn';
  static const columnCompleted = 'completed';
  static const columnReading = 'reading';
  static const columnRating = 'rating';
  static const columnTotalPages = 'pagesTotal';
  static const columnDescription = 'description';
  static const columnAuthorName = 'authorName';


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
    // user table
    db.execute(
        '''
      CREATE TABLE $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL
      )
      '''
    );

  }
  Future<int> insert(Map<String,dynamic>row) async{
    Database? db = await instance.database;
    return await db!.insert(_tableName, row);
  }
  Future<List<Map<String,dynamic>>>queryAll(String tableName)async{
    Database? db = await instance.database;
    return await db!.query(tableName);
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


  Future<dynamic>createDownloadTable(String tableName)async{
    print('table being created : : : ');
    Database? db = await instance.database;
    return await db!.rawQuery('''
    CREATE TABLE $tableName(
    $columnId INTEGER NOT NULL,
    $columnEmail TEXT NOT NULL, 
    $columnISBN TEXT NOT NULL, 
    $columnRating TEXT NOT NULL,
    $columnAuthorName TEXT NOT NULL,
    $columnDescription TEXT NOT NULL,
    $columnTotalPages TEXT NOT NULL,
    $columnBook TEXT NOT NULL,
    )
    ''');
  }
}