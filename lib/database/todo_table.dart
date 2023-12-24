import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list/database/todo_database.dart';
import 'package:todo_list/model/todo.dart';
import './todo_database.dart';

class TodoTable {
  static const TABLE_NAME = "todo";
  static const CREATE_TABLE_QUERY = ''' 
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT
    );
  ''';
  static const DROP_TABLE_QUERY = ''' 
     DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  Future<int> insertTodo(Todo todo) {
    // final Database? db = TodoDatabase.instance.database;
    final Database db = TodoDatabase.instance.database as Database;
    return db.insert(
      TABLE_NAME,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final Database db = TodoDatabase.instance.database as Database;
    await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [todo.getid],
    );
  }

  Future<List<Todo>> selectAllTodo() async {
    final Database db = TodoDatabase.instance.database as Database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (index) {
      return Todo.fromData(
        maps[index]['id'],
        maps[index]['content'],
      );
    });
  }
}
