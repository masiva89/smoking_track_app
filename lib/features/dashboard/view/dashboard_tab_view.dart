import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';
import 'package:flutter_projects/features/dashboard/provider/tab_provider.dart';
import 'package:provider/provider.dart';

class DashboardTabView extends StatefulWidget {
  const DashboardTabView({super.key});

  @override
  State<DashboardTabView> createState() => _DashboardTabViewState();
}

class _DashboardTabViewState extends State<DashboardTabView> {
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return Column(
      children: [
        SizedBox(
          height: topPadding,
        ),
        const DashboardTabBar(),
        Expanded(
          child: Selector<TabProvider, int>(
            selector: (context, provider) => provider.currentTab,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: context.watch<TabProvider>().tabs[value],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DashboardTabBar extends StatefulWidget {
  const DashboardTabBar({super.key});

  @override
  State<DashboardTabBar> createState() => _DashboardTabBarState();
}

class _DashboardTabBarState extends State<DashboardTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: SECOND_GREEN,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem(context, 0, "Günlük"),
          _buildTabItem(context, 1, "Haftalık"),
          _buildTabItem(context, 2, "Aylık"),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int value, String title) {
    return GestureDetector(
      onTap: () {
        context.read<TabProvider>().changeTab(value);
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 68,
          width: screenWidth * 0.95 / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.watch<TabProvider>().currentTab == value
                ? MAIN_GREEN
                : Colors.transparent,
          ),
          child: Center(child: Text(title, style: tabbarActiveTitleTextStyle))),
    );
  }
}
