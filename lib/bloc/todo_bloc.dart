import 'dart:async';
import 'dart:math';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/base/base_event.dart';
import 'package:todo_list/database/todo_table.dart';
import '../model/todo.dart';
import '../event/add_todo_event.dart';
import '../event/delete_todo_event.dart';

// làm các chức năng
class TodoBloc extends BaseBloc {
  TodoTable _todoTable = TodoTable();

  final StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();
  Stream<List<Todo>> get getTodoListStream => _todoListStreamController.stream;
  Sink<List<Todo>> get getTodoListSick => _todoListStreamController.sink;

  final _randomInt = Random();
  List<Todo> _todoListData = <Todo>[];

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if (_todoListData == null) {
      return;
    } else {
      getTodoListSick.add(_todoListData);
    }
  }

  _addTodo(Todo todo) async {
    //insert to dataBase
    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    getTodoListSick.add(_todoListData); // lấy dử liệu lại
  }

  _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);

    _todoListData.remove(todo);
    getTodoListSick.add(_todoListData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo.fromData(_randomInt.nextInt(1000000), event.content);
      _addTodo(todo);
      print(_todoListData.toString());
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
