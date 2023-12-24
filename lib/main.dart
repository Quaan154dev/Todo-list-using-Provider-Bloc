import 'package:flutter/material.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import './todo/todo_list.dart';
import './todo/todo_header.dart';
import './todo/todo_list_container.dart';
import 'package:provider/provider.dart';
import './database/todo_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDatabase.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("TODO-APP"),
        ),
        body: Provider<TodoBloc>.value(
          value: TodoBloc(),
          child: const TodoListContainer(),
        ),
      ),
    );
  }
}
