import 'dart:developer';

import 'package:sqflite/sqflite.dart';

enum FetchType {
  all,
  today,
  week,
  month,
}

class SqfliteManager {
  final String path;
  SqfliteManager({required this.path});
  Database? _db;

  Future<Database?> get database async {
    _db ??= await openDatabase(path);
    return _db;
  }

  Future<void> close() async {
    _db?.close();
    log("Database closed");
  }

  Future<void> delete() async {
    await close();
    await deleteDatabase(path);
    log("Database deleted");
  }

  Future<void> createTable(
      String tableName, Map<String, String> columns) async {
    final database = await _db;
    await database!.execute(
      'CREATE TABLE $tableName (${columns.keys.join(',')})',
    );
  }
}
