import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';
import 'package:flutter_projects/core/database/sqflite_manager.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/dashboard_provider.dart';

class SmokingDatas extends StatefulWidget {
  final FetchType type;

  const SmokingDatas({super.key, required this.type});

  @override
  State<SmokingDatas> createState() => _SmokingDatasState();
}

class _SmokingDatasState extends State<SmokingDatas> {
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return SizedBox(
      height: screenHeight * 0.21,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSmokingData(context, type: FetchType.today),
              _buildTargetSmokingData(context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceData(context, type: FetchType.today),
              _buildTargetBalanceData(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmokingData(BuildContext context, {required FetchType type}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: screenHeight * 0.13,
      width: screenWidth * 0.55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context
              .watch<DashboardProvider>()
              .getLimitCheckColor(type: type)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth * 0.2,
            child: Text(
              context
                  .watch<DashboardProvider>()
                  .getSmokingsByDate(type: type)
                  .length
                  .toString(),
              style: smokingCountText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              "sigara içtin",
              textAlign: TextAlign.start,
              style: smokingDataText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceData(BuildContext context, {required FetchType type}) {
    return Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Harcama:", style: balanceText),
          SizedBox(
              width: screenWidth * 0.2,
              child: Text(
                  "${context.watch<DashboardProvider>().todaySpending} ₺",
                  style: balanceDataText)),
        ],
      ),
    );
  }

  Widget _buildTargetSmokingData(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: screenHeight * 0.13,
      width: screenWidth * 0.39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MAIN_ORANGE,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              "sınır",
              textAlign: TextAlign.start,
              style: smokingDataText,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.2,
            child: Text(
              textAlign: TextAlign.end,
              context.watch<DashboardProvider>().smokingLimit.toString(),
              style: smokingCountText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetBalanceData(BuildContext context) {
    double targetBalance = context.watch<DashboardProvider>().lastSmokingPrice *
        context.watch<DashboardProvider>().smokingLimit;
    return Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MAIN_ORANGE,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Sınır:", style: balanceText),
          Text("${targetBalance.toString()} ₺", style: balanceDataText),
        ],
      ),
    );
  }
}
