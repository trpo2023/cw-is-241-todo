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

  testWidgets('Add new todo item', (WidgetTester tester) async {
    // Создаем экземпляр нашего виджета
    await tester.pumpWidget(TodoListApp());

    // Находим кнопку добавления задачи и нажимаем на нее
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    // Проверяем, что появился диалоговое окно
    expect(find.byType(AlertDialog), findsOneWidget);

    // Вводим текст в текстовое поле и нажимаем на кнопку "Add"
    await tester.tap(find.byType(TextField).last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'New Task');
    final textn = find.text('New Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Проверяем, что новая задача добавлена на экран
    expect(textn, findsOneWidget);
  });

}