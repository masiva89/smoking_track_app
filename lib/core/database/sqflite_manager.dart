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

  static void executeDatabase({required String path}) {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE smokings (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date TEXT,price DOUBLE)',
        );
        await db
            .execute(
          'CREATE TABLE smoking_price (id INTEGER PRIMARY KEY, price DOUBLE)',
        )
            .then((value) {
          db.insert("smoking_price", {"price": 1.5});
          log("db created");
        });
        await db
            .execute(
          'CREATE TABLE smoking_limit (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, smoking_limit INTEGER)',
        )
            .then((value) {
          db.insert('smoking_limit', {"smoking_limit": 11}); //asdasld
        });
        await db
            .execute(
          'CREATE TABLE smoking_time (days INTEGER, months INTEGER, years INTEGER,seconds INTEGER, minutes INTEGER, hours INTEGER)',
        )
            .then((value) {
          db.insert("smoking_time", {
            "seconds": 0,
            "minutes": 0,
            "hours": 0,
            "days": 1,
            "months": 1,
            "years": 2020
          });
        });
        await db
            .execute(
                'CREATE TABLE smoking_last_time (days INTEGER, months INTEGER, years INTEGER, hours INTEGER, minutes INTEGER, seconds INTEGER)')
            .then((value) {
          db.insert(
            'smoking_last_time',
            {
              "seconds": DateTime.now().second,
              "minutes": DateTime.now().minute,
              "hours": DateTime.now().hour,
              "days": DateTime.now().day,
              "months": DateTime.now().month,
              "years": DateTime.now().year,
            },
          );
        });
      },
    );
  }

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
