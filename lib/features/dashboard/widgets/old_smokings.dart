import 'package:flutter/material.dart';
import 'package:flutter_projects/core/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

import 'old_smoking_card.dart';

class OldSmokings extends StatefulWidget {
  final String type;
  const OldSmokings({super.key, required this.type});

  @override
  State<OldSmokings> createState() => _OldSmokingsState();
}

class _OldSmokingsState extends State<OldSmokings> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: context
          .watch<DashboardProvider>()
          .getSmokingsByDate(date: DateTime.now())
          .length,
      itemBuilder: (context, index) {
        return OldSmokingCard(
          smoking: context
              .watch<DashboardProvider>()
              .getSmokingsByDate(date: DateTime.now())[index],
        );
      },
    );
  }
}
