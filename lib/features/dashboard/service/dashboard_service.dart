import 'dart:developer';

import 'package:flutter_projects/core/constants/db_constants.dart';
import 'package:flutter_projects/features/dashboard/model/smoking.dart';

import '../../../core/database/sqflite_manager.dart';

class DashboardService {
  final db = SqfliteManager(path: DB_PATH).database;
  DashboardService._init();
  static final DashboardService _instance = DashboardService._init();
  factory DashboardService() => _instance;

  Future<List<Smoking>> fetchSmokingsByDate({required DateTime date}) async {
    var result = [];
    final database = await db;
    if (database != null) {
      try {
        result = await database.query(
          "smokings",
          where: "date = ?",
          whereArgs: [date.toIso8601String()],
        );
        log(result.toString());
      } catch (e) {
        log("DashboardService fetchSmokingsByDate error: $e");
      }
    } else {
      result = [];
    }
    return result.map((e) => Smoking.fromJson(e)).toList();
  }

  Future<List<Smoking>> fetchSmokings({FetchType type = FetchType.all}) async {
    final List<Smoking> smokings = [];
    final database = await db;
    if (database != null) {
      if (type == FetchType.all) {
        final List<Map<String, dynamic>> maps =
            await database.query('smokings');
        maps.forEach((map) {
          smokings.add(Smoking.fromJson(map));
        });
      } else if (type == FetchType.today) {
        final List<Map<String, dynamic>> maps = await database.query(
          'smokings',
          where: 'date = BETWEEN ? AND ?',
          whereArgs: [
            DateTime.now().toString(),
            DateTime.now().add(Duration(days: 1)).toString()
          ],
        );
        maps.forEach((map) {
          smokings.add(Smoking.fromJson(map));
        });
      } else if (type == FetchType.week) {
        final List<Map<String, dynamic>> maps = await database.query('smokings',
            where: 'date BETWEEN ? AND ?',
            whereArgs: [
              DateTime.now().subtract(Duration(days: 6)).toString(),
              DateTime.now().toString()
            ]);
        maps.forEach((map) {
          smokings.add(Smoking.fromJson(map));
        });
      } else if (type == FetchType.month) {
        final List<Map<String, dynamic>> maps = await database
            .query('smokings', where: 'date BETWEEN ? AND ?', whereArgs: [
          DateTime.now().subtract(Duration(days: 30)).toString(),
          DateTime.now().toString()
        ]);
        maps.forEach((map) {
          smokings.add(Smoking.fromJson(map));
        });
      }
    }

    return smokings;
  }

  Future<bool> addSmoking({required Smoking smoking}) async {
    final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      await database.insert('smokings', smoking.toJson());
      await saveLastSmokingTime(dateTime: DateTime.now());
      return true;
    }
    return false;
  }

  Future<bool> removeSmoking({required Smoking smoking}) async {
    log("removeSmoking");
    final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      try {
        await database
            .delete('smokings', where: 'id = ?', whereArgs: [smoking.id]);
      } catch (e) {
        print(e);
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> updateSmoking({required Smoking smoking}) async {
    final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      try {
        await database.update('smokings', smoking.toJson(),
            where: 'id = ?', whereArgs: [smoking.id]);
      } catch (e) {
        print(e);
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> clearSmokings() async {
    final database = await db;
    if (database != null) {
      await database.delete('smokings');
      return true;
    }
    return false;
  }

  Future<double> getSmokingPrice() async {
    final database = await db;
    if (database != null) {
      final List<Map<String, dynamic>> maps =
          await database.query('smoking_price');
      if (maps.isNotEmpty) {
        log("${maps.first['price']}");
        return maps.first['price'] as double;
      }
    }
    return 0;
  }

  Future<bool> setSmokingPrice({required double price}) async {
    final database = await db;
    if (database != null) {
      await database.delete('smoking_price');
      await database.insert('smoking_price', {'price': price});
      return true;
    }
    return false;
  }

  Future<bool> setSmokingLimit({required int limit}) async {
    final database = await db;
    if (database != null) {
      await database.delete('smoking_limit');
      await database.insert('smoking_limit', {'smoking_limit': limit});
      return true;
    }
    return false;
  }

  Future<int> getSmokingLimit() async {
    final database = await db;
    if (database != null) {
      final List<Map<String, dynamic>> maps =
          await database.query('smoking_limit');
      if (maps.isNotEmpty) {
        log("smoking limit: ${maps.first['smoking_limit']}");
        return maps.first['smoking_limit'] as int;
      }
    }
    return 0;
  }

  Future<double> getLastSmokingPrice() async {
    final database = await db;
    if (database != null) {
      final List<Map<String, dynamic>> maps =
          await database.query('smoking_price');
      if (maps.isNotEmpty) {
        log("${maps.first['price']}");
        return maps.first['price'] as double;
      }
    }
    return 0;
  }

  Future<bool> saveTime({required DateTime dateTime}) async {
    log("saveTime");
    final database = await db;
    if (database != null) {
      await database.delete('smoking_time');
      await database.insert('smoking_time', {
        'days': dateTime.day,
        'months': dateTime.month,
        'years': dateTime.year,
        'hours': dateTime.hour,
        'minutes': dateTime.minute,
        'seconds': dateTime.second
      });
      return true;
    }
    return false;
  }

  Future<bool> saveLastSmokingTime({required DateTime dateTime}) async {
    log("saveLastSmokingTime");
    final database = await db;
    if (database != null) {
      await database.delete('smoking_last_time');
      await database.insert('smoking_last_time', {
        'days': dateTime.day,
        'months': dateTime.month,
        'years': dateTime.year,
        'hours': dateTime.hour,
        'minutes': dateTime.minute,
        'seconds': dateTime.second
      });
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>?> getLastSmokingTime() async {
    final database = await db;
    if (database != null) {
      final List<Map<String, dynamic>> maps =
          await database.query('smoking_last_time');
      if (maps.isNotEmpty) {
        return maps.first;
      }
      return null;
    }
    return null;
    /* final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      final List<Map<String, dynamic>> maps =
          await database.query('smoking_time');
      if (maps.isNotEmpty) {
        return maps.first;
      }
    }
    return null; */
  }
}
