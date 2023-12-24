import 'package:todo_list/database/todo_table.dart';

import '../model/todo.dart';
import '../service/todo_service.dart';

class TodoRepo {
  TodoTable _todoTable = TodoTable();
  TodoService todoService = TodoService();

  Future<int> insertTodo(Todo todo) async {
    return _todoTable.insertTodo(todo);
  }

  Future<List<Todo>> selectAllTodo() async {
    return _todoTable.selectAllTodo();
  }

  Future<List<Todo>> initData() async {
    List<Todo> data = [];
    data = await _todoTable.selectAllTodo();
    if (data.length == 0) {
      return await todoService.getTodoList();
    }
    return data;
  }
}
