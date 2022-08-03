import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_projects/core/database/sqflite_manager.dart';
import 'package:flutter_projects/core/providers/dashboard_provider.dart';
import 'package:flutter_projects/features/dashboard/model/smoking.dart';
import 'package:flutter_projects/features/dashboard/service/dashboard_service.dart';
import 'package:provider/provider.dart';

import '../../../widgets/add_smoking_button.dart';
import '../../../widgets/content_header.dart';
import '../../../widgets/old_smokings.dart';
import '../../../widgets/smoking_datas.dart';

class DashboardWeeklyView extends StatefulWidget {
  const DashboardWeeklyView({super.key});

  @override
  State<DashboardWeeklyView> createState() => _DashboardWeeklyViewState();
}

class _DashboardWeeklyViewState extends State<DashboardWeeklyView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: const [
        ContentHeader(title: "Genel Bakış"),
        SizedBox(height: 7),
        SmokingDatas(
          type: FetchType.week,
        ),
        SizedBox(height: 7),
        AddSmokingButton(),
        SizedBox(height: 7),
        ContentHeader(title: "Geçmiş"),
        SizedBox(height: 7),
        OldSmokings(
          type: FetchType.week,
        ),
      ],
    );
  }
}
