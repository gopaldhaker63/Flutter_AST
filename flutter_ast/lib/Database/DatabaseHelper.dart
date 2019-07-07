import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_ast/TaskModel/TaskModel.dart';

class DatabaseHelper {
  static final _databaseName = "TaskDB.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructer();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructer();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectiryPath = await getApplicationDocumentsDirectory();
    String path = join(documentDirectiryPath.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableTaskInfo(
      $columnTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTaskTitle TEXT NOT NULL,
      $columnTaskDescription TEXT NOT NULL,
      $columnTaskDate TEXT NOT NULL,  
      $columnIsComplete TEXT  
    )
    ''');
  }

  Future<int> inserAccount(TaskModel taskModel) async {
    Database db = await database;
    int taskId = await db.insert(tableTaskInfo, taskModel.toMap());
    return taskId;
  }

  Future<List<TaskModel>> getAllTask() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery('SELECT * FROM taskinfo ORDER BY taskdate DESC');
      List<TaskModel> taskModel = [];
      maps.forEach((map) => taskModel.add(TaskModel.fromMap(map)));
      return taskModel;
  }

  Future<int> deleteAccount(int taskId) async {
    Database db = await database;
    return db.delete(tableTaskInfo,
        where: '$columnTaskId = ?', whereArgs: [taskId]);
  }

  Future<int> updateTask(TaskModel taskModel) async {
    Database db = await database;
    return await db.update(tableTaskInfo, taskModel.toMap(),
        where: '$columnTaskId=?', whereArgs: [taskModel.taskId]);
  }
}

