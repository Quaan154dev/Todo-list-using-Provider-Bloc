import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/event/delete_todo_event.dart';

import '../model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
        stream: bloc.getTodoListStream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount:
                snapshot.data?.length, //snapshot.data chính là cái <List<Todo>>
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snapshot.data?[index].getcontent ?? "",
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    bloc.getevent.add(DeleteTodoEvent(snapshot.data![index]));
                  },
                  child: Icon(Icons.delete, color: Colors.red[400]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
