import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';
import 'package:flutter_projects/core/providers/page_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/dashboard_provider.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardProvider>().setSmokings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<PageProvider, int>(
        selector: (context, provider) => provider.currentPage,
        builder: (context, currentPage, child) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: LIGHT_COLOR,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              context.watch<PageProvider>().pages[currentPage],
                            ],
                          ),
                        ),
                        const BottomTabBar(),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return Container(
      height: 68,
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: SECOND_ORANGE,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem(context, 0, "Ana Sayfa", Icons.dashboard_outlined),
          _buildTabItem(context, 1, "Grafikler", Icons.graphic_eq_outlined),
          _buildTabItem(context, 2, "Ayarlar", Icons.settings_outlined),
        ],
      ),
    );
  }

  Widget _buildTabItem(
      BuildContext context, int value, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        context.read<PageProvider>().changePage(value);
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 68,
          width: screenWidth * 0.95 / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.watch<PageProvider>().currentPage == value
                ? MAIN_ORANGE
                : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: LIGHT_COLOR,
                size: 40,
              ),
              Text(title, style: navbarInactiveTitleTextStyle)
            ],
          )),
    );
  }
}
