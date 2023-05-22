import 'package:flutter/material.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
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
                    _items.add(newTodo);
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

  void _removeTodoItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _editTodoItem(String newValue, int index) {
    setState(() {
      _items[index] = newValue;
    });
  }

  Widget _buildTodoItem(String item, int index) {
    return Dismissible(
      key: Key('$item$index'),
      onDismissed: (direction) => _removeTodoItem(index),
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
                            _editTodoItem(controller.text, index);
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
              onPressed: () => _removeTodoItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTodoItem(_items[index], index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter a task',
            ),
            onTap: () {
              _showAddTodoDialog();
            },
          ),
          Expanded(
            child: _buildTodoList(),
          ),
        ],
      ),
    );
  }
}
