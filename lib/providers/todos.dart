import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> addTodo(String todo, bool isCompleted) async {
  final prefs = await SharedPreferences.getInstance();
  final todosList = prefs.getStringList('todos') ?? []; 
  todosList.add(json.encode({'task': todo, 'isCompleted': isCompleted}));
  await prefs.setStringList('todos', todosList);
}

Future<List> getAllTodos() async {
  final prefs = await SharedPreferences.getInstance();
  final todosList = prefs.getStringList('todos') ?? [];
  final todosWithStatus = todosList.map((todoJson) => json.decode(todoJson)).toList();
  return todosWithStatus; 
}

Future<void> deleteTodo(int index) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? todosStringList = prefs.getStringList('todos');
  if (todosStringList != null) {
    todosStringList.removeAt(index);
    await prefs.setStringList('todos', todosStringList);
  }
}

Future<void> updateTodo(int index, bool newValue) async {
  final prefs = await SharedPreferences.getInstance();
  final todosString = prefs.getStringList('todos');
  
  if (todosString == null) {
    return;
  }
  
  final todos = todosString.map((jsonString) => json.decode(jsonString)).toList();
  
  if (index >= todos.length) {
    return;
  }
  
  todos[index]['isCompleted'] = newValue;
  
  final newTodosString = todos.map((todo) => json.encode(todo)).toList();
  await prefs.setStringList('todos', newTodosString);
}
