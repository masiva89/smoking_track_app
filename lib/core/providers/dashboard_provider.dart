import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/database/sqflite_manager.dart';
import 'package:flutter_projects/features/dashboard/service/dashboard_service.dart';

import '../../features/dashboard/model/smoking.dart';

class DashboardProvider extends ChangeNotifier {
  List<Smoking> smokings = [];
  List<Smoking> todaySmokings = [];
  List<Smoking> weekSmokings = [];
  List<Smoking> monthSmokings = [];
  List<Smoking> get getSmokings => smokings;
  List<Smoking> get getTodaySmokings => todaySmokings;
  int smokingLimit = 0;
  int get getSmokingLimit => smokingLimit;

  bool isUnderLimitToday = true;
  bool isUnderLimitWeek = true;
  bool isUnderLimitMonth = true;

  double lastSmokingPrice = 0;
  double get getLastSmokingPrice => lastSmokingPrice;

  double todaySpending = 0;

  final service = DashboardService();

  DashboardProvider() {
    setSmokings();
    getSmokingLimitData();
    checkSmokingLimit();
    getLastSmokingPriceData();
    setTodaySpending();
  }

  Future<void> setTodaySpending() async {
    log("setTodaySpending");
    final todaySmokings = await service.fetchSmokings(type: FetchType.today);
    log("todaySmokings: ${todaySmokings.length}");
    for (final smoking in todaySmokings) {
      todaySpending += smoking.price;
    }
    notifyListeners();
    log("todaySpending: $todaySpending");
  }

  void increaseTodaySpending(double price) {
    todaySpending += price;
  }

  Future<void> addSmoking(Smoking smoking) async {
    await service.addSmoking(smoking: smoking).whenComplete(() {
      smokings.add(smoking);
      todaySmokings.add(smoking);
      weekSmokings.add(smoking);
      checkSmokingLimit();
      increaseTodaySpending(smoking.price);
    });
    notifyListeners();
  }

  void checkSmokingLimit() {
    if (todaySmokings.length > smokingLimit) {
      log("todaySmokings.length: ${todaySmokings.length}");
      log("smokingLimit: $smokingLimit");
      isUnderLimitToday = false;
    } else {
      isUnderLimitToday = true;
      log("isUnderLimit: $isUnderLimitToday");
    }
    if (weekSmokings.length > smokingLimit) {
      isUnderLimitWeek = false;
    } else {
      isUnderLimitWeek = true;
    }
    if (monthSmokings.length > smokingLimit) {
      isUnderLimitMonth = false;
    } else {
      isUnderLimitMonth = true;
    }
    notifyListeners();
  }

  Future<void> removeSmoking(Smoking smoking) async {
    await service.removeSmoking(smoking: smoking).whenComplete(() {
      smokings.removeWhere((element) {
        return element.id == smoking.id;
      });
    });
    notifyListeners();
  }

  Future<void> updateSmoking(Smoking smoking) async {
    await service.updateSmoking(smoking: smoking).whenComplete(() {
      int? index;
      smokings.removeWhere((element) {
        if (element.id == smoking.id) {
          index = smokings.indexOf(element);
          return true;
        }
        return false;
      });
      smokings.insert(index!, smoking);
    });
    notifyListeners();
  }

  Future<void> clearSmokings() async {
    await service.clearSmokings().whenComplete(() {
      smokings.clear();
    });
    notifyListeners();
  }

  Future<List<Smoking>> setSmokings() async {
    try {
      await service.fetchSmokings().then((value) {
        smokings = value;
        todaySmokings = value.where((element) {
          String stringDate = element.dateTime;
          String today = DateTime.now().toString();
          return stringDate.substring(0, 10) == today.substring(0, 10);
        }).toList();
        log("todaySmokings: ${todaySmokings.length}");
        notifyListeners();
      });
      await service.fetchSmokings(type: FetchType.week).then((value) {
        weekSmokings = value;
        log("weekSmokings: ${weekSmokings.length}");
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
    }
    return smokings;
  }

  List<Smoking> getSmokingsByDate({required FetchType type}) {
    final DateTime date = DateTime.now();

    /* if (type == FetchType.today) {
      return todaySmokings;
    } else if (type == FetchType.week) {
      return weekSmokings;
    } else if (type == FetchType.month) {
      return monthSmokings;
    } else {
      return smokings;
    } */
    return smokings.where((element) {
      return element.dateFormat().day == date.day &&
          element.dateFormat().month == date.month &&
          element.dateFormat().year == date.year;
    }).toList();
  }

  Future<void> setSmokingLimitData({required int limit}) async {
    try {
      await service.setSmokingLimit(limit: limit).then((value) {
        if (value) {
          smokingLimit = limit;
          notifyListeners();
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getSmokingLimitData() async {
    try {
      await service.getSmokingLimit().then((value) {
        if (value != null) {
          smokingLimit = value;
          notifyListeners();
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getLastSmokingPriceData() async {
    try {
      await service.getLastSmokingPrice().then((value) {
        if (value != null) {
          lastSmokingPrice = value;
          notifyListeners();
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Color getLimitCheckColor({required FetchType type}) {
    if (type == FetchType.today) {
      return isUnderLimitToday ? successColor : failColor;
    } else if (type == FetchType.week) {
      return isUnderLimitWeek ? successColor : failColor;
    } else if (type == FetchType.month) {
      return isUnderLimitMonth ? successColor : failColor;
    }
    return successColor;
  }
}
