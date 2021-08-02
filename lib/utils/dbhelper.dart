import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

class Dbhelper {
  static final Dbhelper _dbhelper = Dbhelper._internal();
  String tblTodo = "todo";
  String coId = "id";
  String coTitle = "title";
  String coDescription = "description";
  String coDate = "date";
  String coPriority = "priority";
  Dbhelper._internal();
  factory Dbhelper() {
    return _dbhelper;
  }
  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todo.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTodo($coId INTEGER PRIMARY KEY, $coTitle TEXT," +
            "$coDescription TEXT, $coPriority INTEGER, $coDate TEXT)");
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodo() async {
    Database db = await this.db;
    var result = db.rawQuery("SELECT * FROM $tblTodo order by $coPriority ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count(*) FROM $tblTodo"));
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    Database db = await this.db;
    var result = db.update(tblTodo, todo.toMap(),
        where: "$coId = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.db;
    var result = await db.rawDelete('DELETE FROM $tblTodo WHERE $coId = $id');
    return result;
  }
}
