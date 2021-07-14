import 'dart:io';

import 'package:path/path.dart';
import 'package:todo/tod_model.dart';

class TaskDbHelper {
  TaskDbHelper._();
  static TaskDbHelper taskDbHelper = TaskDbHelper._();
  static final String databaseName = 'tasksDatabase.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'taskId';
  static final String taskNameColumnName = 'taskName';
  static final String taskIsCompleteColumnName = 'isComplete';
  Database database;
  initializeTasksDatabase() async {
    if (database == null) {
      database = await connectToTasksDatabase();
    }
  }

  Future<Database> connectToTasksDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databasePath = join(directory.path, databaseName);
    Database database =
        await openDatabase(databasePath, version: 2, onCreate: (db, version) {
      createTasksTable(db);
    });
    return database;
  }

  createTasksTable(Database database) {
    database.execute('''CREATE TABLE $tableName(
     $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
     $taskNameColumnName TEXT NOT NULL,
     $taskIsCompleteColumnName INTEGER NOT NULL
      )''');
  }

  insertNewTask(Task task) async {
    try {
      int rowNumber = await database.insert(tableName, task.toMap());
      print(rowNumber);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> selectAllTasks() async {
    try {
      List<Map<String, dynamic>> allRows = await database.query(tableName);
      return allRows;
    } on Exception catch (e) {
      print(e);
    }
  }

  getOneTask(int taskId) async {
    try {
      List<Map<String, dynamic>> result = await database
          .query(tableName, where: '$taskIdColumnName=?', whereArgs: [taskId]);
    } on Exception catch (e) {
      // TODO
    }
  }

  updateTask(Task task) async {
    database.update(tableName, task.toMap(),
        where: '$taskIdColumnName=?', whereArgs: [task.taskId]);
  }

  deleteTask(int taskId) async {
    database
        .delete(tableName, where: '$taskIdColumnName=?', whereArgs: [taskId]);
  }

  deleteAllTasks() async {
    database.delete(tableName);
  }
}
