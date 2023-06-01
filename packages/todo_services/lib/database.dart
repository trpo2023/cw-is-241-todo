import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'data_models/dbtodo.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "TodoDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE TODO_LIST ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT"
          ")");
    });
  }

  addTodo(DBTodo todo) async {
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT Into TODO_LIST (id, title) "
      " VALUES (?,?)",
      [todo.id, todo.title],
    );
    return raw;
  }

  Future<List<DBTodo>> getAllTodo() async {
    final db = await database;
    var res = await db.query("TODO_LIST");
    List<DBTodo> list =
        res.isNotEmpty ? res.map((e) => DBTodo.fromMap(e)).toList() : [];
    return list;
  }

  deleteTodoId(int id) async {
    final db = await database;
    return db.delete("TODO_LIST", where: "id = ?", whereArgs: [id]);
  }

  editTodo(DBTodo todo) async {
    final db = await database;
    var res = await db.update(
      "TODO_LIST",
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
    return res;
  }
}
