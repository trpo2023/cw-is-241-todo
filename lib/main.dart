import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:todo_models/todo_model.dart';
import 'package:todo_repository/todo_repository.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  var count = 0;
  final _textController = TextEditingController();
  final _items = <String>[];

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Add a task'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final newTodo = controller.text;
                if (newTodo.isNotEmpty) {
                  setState(() {
                    final todo = TodoModel(
                      id: count = count + 1,
                      title: newTodo,
                    );
                    TodoRepository().addTodo(todo);
                    _textController.clear();
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _removeTodoItem(int id) {
    setState(() {
      TodoRepository().deleteTodoId(id);
    });
  }

  void _editTodoItem(String newValue, int index, int itemid) {
    setState(() {
      final todo = TodoModel(
        id: itemid,
        title: newValue,
      );
      TodoRepository().editTodo(todo);
    });
  }

  Widget _buildTodoItem(String item, int index, int id) {
    return Dismissible(
      key: Key('$item$index'),
      onDismissed: (direction) => _removeTodoItem(id),
      child: ListTile(
        title: Text(item),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController controller =
                        TextEditingController(text: item);
                    return AlertDialog(
                      title: Text('Edit a task'),
                      content: TextField(
                        controller: controller,
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text('Save'),
                          onPressed: () {
                            _editTodoItem(controller.text, index, id);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeTodoItem(id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return Scaffold(
      body: FutureBuilder(
        future: TodoRepository().getAllTodo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final todo = snapshot.data as List<TodoModel>;
          return ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              return _buildTodoItem(todo[index].title, index, todo[index].id);
            },
          );
        },
      ),
    );
  }

  // ListView.builder(
  //     itemCount: _items.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildTodoItem(_items[index], index);
  //     },
  //   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildTodoList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
