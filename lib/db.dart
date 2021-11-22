import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const _dbname = 'Rooms.db';
  static const _dbVersion = 1;
  static const tableName = 'MyUsers';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnBook = 'title';
  static const columnEmail = 'email';
  static const columnPage = 'page_num';
  static const columnISBN = 'isbn';
  static const columnCompleted = 'completed';
  static const columnReading = 'read';
  static const columnRating = 'rating';
  static const columnTotalPages = 'pages';
  static const columnDescription = 'description';
  static const columnAuthorName = 'Author';
  static const columnImgLink = 'img_link';


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
      CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT,
      $columnEmail TEXT NOT NULL
      )
      '''
    );

  }
  Future<int> insert(Map<String,dynamic> row, String tableName) async{
    Database? db = await instance.database;
    return await db!.insert(tableName, row);
  }
  Future<List<Map<String,dynamic>>>queryAll(String tableName)async{
    Database? db = await instance.database;
    return await db!.query(tableName);
  }
  Future<List<Map<String,dynamic>>>querySome(String name)async{
    Database? db = await instance.database;
    return await db!.query(tableName, columns: [columnId],where:'${DatabaseHelper.columnEmail} = ?',whereArgs: [name]);
  }
  Future<List<Map<String,dynamic>>>getUser(int id)async{
    Database? db = await instance.database;
    return await db!.query(tableName, columns: [columnEmail],where:'${DatabaseHelper.columnId} = ?',whereArgs: [id]);
  }
  Future<int>update(Map<String,dynamic> row) async{
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> delete(int id)async{
    Database? db = await instance.database;
    print('id deleted successfully'); // debug print
    return await db!.delete(tableName,where: '$columnId = ?', whereArgs: [id]);
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
    $columnId INTEGER PRIMARY KEY,
    $columnEmail TEXT NOT NULL, 
    $columnISBN TEXT NOT NULL, 
    $columnRating TEXT NOT NULL,
    $columnAuthorName TEXT NOT NULL,
    $columnDescription TEXT NOT NULL,
    $columnTotalPages TEXT NOT NULL,
    $columnBook TEXT NOT NULL,
    $columnImgLink TEXT NOT NULL
    )
    ''');
  }
}