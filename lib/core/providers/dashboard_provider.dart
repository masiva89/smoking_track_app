import 'package:flutter/material.dart';
import 'package:flutter_projects/features/dashboard/service/dashboard_service.dart';

import '../../features/dashboard/model/smoking.dart';

class DashboardProvider extends ChangeNotifier {
  List<Smoking> smokings = [];
  List<Smoking> get getSmokings => smokings;

  final service = DashboardService();

  Future<void> addSmoking(Smoking smoking) async {
    await service.addSmoking(smoking).whenComplete(() {
      smokings.add(smoking);
    });
    notifyListeners();
  }

  Future<void> removeSmoking(Smoking smoking) async {
    await service.removeSmoking(smoking).whenComplete(() {
      smokings.removeWhere((element) {
        return element.id == smoking.id;
      });
    });
    notifyListeners();
  }

  Future<void> updateSmoking(Smoking smoking) async {
    await service.updateSmoking(smoking).whenComplete(() {
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
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
    return smokings;
  }

  List<Smoking> getSmokingsByDate({required DateTime date}) {
    return smokings.where((element) {
      return element.dateFormat().day == date.day &&
          element.dateFormat().month == date.month &&
          element.dateFormat().year == date.year;
    }).toList();
  }
}
