import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/event/add_todo_event.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: txtTodoController,
            decoration: const InputDecoration(
                labelText: "Add TODO", hintText: "Add TODO"),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {
            bloc.getevent.add(
              AddTodoEvent(txtTodoController.text),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text("Add"),
        )
      ],
    );
  }
}
