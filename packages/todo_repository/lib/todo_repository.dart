import 'package:todo_services/data_models/dbtodo.dart';
import 'package:todo_models/todo_model.dart';
import 'package:todo_services/database.dart';

class TodoRepository {
  Future<void> addTodo(TodoModel todo) async {
    await DBProvider.db.addTodo(DBTodo(
      id: todo.id,
      title: todo.title,
    ));
  }

  Future<List<TodoModel>> getAllTodo() async {
    final tt = await DBProvider.db.getAllTodo();
    return tt
        .map((e) => TodoModel(
              id: e.id,
              title: e.title,
            ))
        .toList();
  }

  Future<void> deleteTodoId(int id) async {
    await DBProvider.db.deleteTodoId(id);
  }

  Future editTodo(TodoModel todo) async {
    final result = await DBProvider.db.editTodo(DBTodo(
      id: todo.id,
      title: todo.title,
    ));
    return result;
  }
}
