import 'package:flutter/material.dart';
import 'package:flutter_projects/core/database/sqflite_manager.dart';
import 'package:flutter_projects/features/dashboard/widgets/content_header.dart';

import '../../../widgets/add_smoking_button.dart';
import '../../../widgets/old_smokings.dart';
import '../../../widgets/smoking_datas.dart';
import '../../../widgets/smoking_time_counter.dart';

class DashboardDailyView extends StatefulWidget {
  const DashboardDailyView({super.key});

  @override
  State<DashboardDailyView> createState() => _DashboardDailyViewState();
}

class _DashboardDailyViewState extends State<DashboardDailyView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: const [
        ContentHeader(title: "Genel Bakış"),
        SizedBox(height: 7),
        SmokingDatas(
          type: FetchType.today,
        ),
        SizedBox(height: 7),
        SmokingTimeCounter(),
        SizedBox(height: 7),
        AddSmokingButton(),
        SizedBox(height: 7),
        ContentHeader(title: "Geçmiş"),
        SizedBox(height: 7),
        OldSmokings(
          type: FetchType.today,
        ),
      ],
    );
  }
}
