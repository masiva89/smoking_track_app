import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';

class SmokingDatas extends StatefulWidget {
  const SmokingDatas({super.key});

  @override
  State<SmokingDatas> createState() => _SmokingDatasState();
}

class _SmokingDatasState extends State<SmokingDatas> {
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return Container(
      height: screenHeight * 0.21,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSmokingData(context),
              _buildTargetSmokingData(context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceData(context),
              _buildTargetBalanceData(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmokingData(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: screenHeight * 0.13,
      width: screenWidth * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "18",
            style: smokingCountText,
          ),
          Text(
            "sigara içtin",
            textAlign: TextAlign.start,
            style: smokingDataText,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceData(BuildContext context) {
    double balance = 6.0;
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
          Text("Kazancınız:", style: balanceText),
          Text("${balance.toString()} ₺", style: balanceDataText),
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
          Text(
            "sınır",
            textAlign: TextAlign.start,
            style: smokingDataText,
          ),
          Text(
            "19",
            style: smokingCountText,
          ),
        ],
      ),
    );
  }

  Widget _buildTargetBalanceData(BuildContext context) {
    double targetBalance = 100.0;
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
