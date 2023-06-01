import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:todo_models/todo_model.dart';

void main() {
  group('TodoListApp', () {
    testWidgets('renders MaterialApp', (tester) async {
      await tester.pumpWidget(TodoListApp());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('TodoListPage', () {
    testWidgets('renders AppBar', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TodoListPage()));
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders FloatingActionButton', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TodoListPage()));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
