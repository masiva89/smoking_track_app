import 'dart:developer';

import 'package:flutter_projects/features/dashboard/model/smoking.dart';
import 'package:flutter_projects/features/dashboard/service/dashboard_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test("update object", () async {
    final service = DashboardService();
    final smoking = Smoking.fromJson(
        {'id': 16, 'date': DateTime.now().toIso8601String(), 'price': 1.0});
    final response = await service.updateSmoking(smoking);
    log(response.toString());
  });

  test("get price", () async {
    final service = DashboardService();

    final response = await service.getSmokingPrice();
    log(response.toString());
  });
}
