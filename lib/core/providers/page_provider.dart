import 'package:flutter/material.dart';
import 'package:flutter_projects/features/graphics/view/graphics_view.dart';

import '../../features/dashboard/view/dashboard_tab_view.dart';
import '../../features/settings/view/settings_view.dart';

class PageProvider extends ChangeNotifier {
  final List<Widget> pages = const [
    DashboardTabView(),
    GraphicsView(),
    SettingsView(),
  ];

  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    notifyListeners();
  }
}
