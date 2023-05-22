import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Todo List App', (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(TodoListApp());

    // Проверяем, что заголовок приложения отображается
    expect(find.text('Todo List'), findsOneWidget);
  });
