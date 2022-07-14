import 'dart:developer';

import 'package:flutter_projects/features/dashboard/model/smoking.dart';

import '../../../core/database/sqflite_manager.dart';

class DashboardService {
  DashboardService._init();
  static final DashboardService _instance = DashboardService._init();
  factory DashboardService() => _instance;

  Future<List<Smoking>> fetchSmokings({FetchType type = FetchType.all}) async {
    final List<Smoking> smokings = [];
    final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      if (type == FetchType.all) {
        final List<Map<String, dynamic>> maps =
            await database.query('smokings');
        maps.forEach((map) {
          smokings.add(Smoking.fromJson(map));
        });
      } else if (type == FetchType.today) {
        final List<Map<String, dynamic>> maps = await database.query('smokings',
            where: 'date = ?', whereArgs: [DateTime.now().toString()]);
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

  Future<bool> addSmoking(Smoking smoking) async {
    final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      await database.insert('smokings', smoking.toJson());
      return true;
    }
    return false;
  }

  Future<bool> removeSmoking(Smoking smoking) async {
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

  Future<bool> updateSmoking(Smoking smoking) async {
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
    final database = await SqfliteManager(path: 'smoking_track.db').database;
    if (database != null) {
      await database.delete('smokings');
      return true;
    }
    return false;
  }

  Future<double> getSmokingPrice() async {
    final database = await SqfliteManager(path: 'smoking_track.db').database;
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
}
