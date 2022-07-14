import 'package:flutter/material.dart';

import '../features/daily/view/dashboard_daily_view.dart';
import '../features/monthly/view/dashboard_monthly_view.dart';
import '../features/weekly/view/dashboard_weekly_view.dart';

class TabProvider extends ChangeNotifier {
  final tabs = const [
    DashboardDailyView(),
    DashboardWeeklyView(),
    DashboardMonthlyView(),
  ];

  int currentTab = 0;
  void changeTab(int index) {
    currentTab = index;
    notifyListeners();
  }
}
