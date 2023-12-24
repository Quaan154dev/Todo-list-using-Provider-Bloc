import 'dart:async';
import 'dart:math';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/base/base_event.dart';
import 'package:todo_list/database/todo_table.dart';
import 'package:todo_list/repository/todo_repo.dart';
import '../model/todo.dart';
import '../event/add_todo_event.dart';
import '../event/delete_todo_event.dart';

// làm các chức năng và chứa tài nguyên
class TodoBloc extends BaseBloc {
  TodoRepo _todoRepo = new TodoRepo();
  TodoTable _todoTable = TodoTable(); // database

  final StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();
  Stream<List<Todo>> get getTodoListStream => _todoListStreamController.stream;
  Sink<List<Todo>> get getTodoListSick => _todoListStreamController.sink;

  final _randomInt = Random();
  List<Todo> _todoListData = []; // khởt tạo list ra

  initData() async {
    var data = await _todoRepo.initData();
    _todoListData = await _todoTable.selectAllTodo();
    getTodoListSick.add(data);
    // if (_todoListData == null) {
    //   return;
    // } else {
    // }
  }

  _addTodo(Todo todo) async {
    //insert to dataBase
    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    getTodoListSick.add(_todoListData); // đẩy event vào
  }

  _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);

    _todoListData.remove(todo);
    getTodoListSick.add(_todoListData); // đẩy event vào
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo.fromData(_randomInt.nextInt(1000000),
          event.content); //create  1 instance then add
      _addTodo(todo); // add instance to List
      print(_todoListData.toString());
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo); // xoá từng đối tượng cụ thể
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
