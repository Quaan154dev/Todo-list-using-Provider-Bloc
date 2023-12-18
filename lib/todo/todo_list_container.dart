import 'package:flutter/material.dart';
import 'todo_header.dart';
import 'todo_list.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          TodoHeader(),
          Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
