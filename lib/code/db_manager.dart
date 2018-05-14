import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String TABLE_NAME = "tasks";
final String ID = "_id";
final String TITLE = "title";
final String DETAIL = "detail";
final String COMPLETED = "completed";

class DbManager {

  Database _database;

  Future openDb() async {
    if (_database == null) {
      Directory directory = await getApplicationDocumentsDirectory();
      _database = await openDatabase(
          join(directory.path, "notes.db"),
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''create table $TABLE_NAME (
         $ID integer primary key autoincrement,
         $TITLE text not null,
         $DETAIL text not null,
         $COMPLETED integer not null)''');
          });
    }
  }

  Future<int> insertTask(Task task) async {
    return await _database.insert(TABLE_NAME, task.toMap());
  }

  Future<List<Task>> getTasks() async {
    await openDb();
    List<Map> entities = await _database.rawQuery("select * from $TABLE_NAME");
    return entities
        .map((map) => new Task.fromMap(map))
        .toList();
  }

  Future deleteTask(int id) async {
    await openDb();
    await _database.delete(TABLE_NAME, where: "$ID = ?", whereArgs: [id]);
  }

  Future updateTask(Task task) async {
    await openDb();
    await _database.update(TABLE_NAME, task.toMap(), where: "$ID = ?", whereArgs: [task.id]);
  }

  closeDb() {
    _database.close();
  }
}

class Task {

  int id;
  String title;
  String detail;
  int completed;

  Task({@required this.title, this.detail, this.id, this.completed = 0});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {TITLE: title, DETAIL: detail, COMPLETED: completed};
    return map;
  }

  Task.fromMap(Map map){
    id = map[ID];
    title = map[TITLE];
    detail = map[DETAIL];
    completed = map[COMPLETED] ?? 0;
  }

  @override
  bool operator ==(other) {
    return other is Task && other.title == title && other.detail == detail && other.id == id && other.completed == completed;
  }
}