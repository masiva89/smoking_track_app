import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import '../../../core/providers/timer_provider.dart';

class SmokingTimeCounter extends StatefulWidget {
  const SmokingTimeCounter({super.key});

  @override
  State<SmokingTimeCounter> createState() => _SmokingTimeCounterState();
}

class _SmokingTimeCounterState extends State<SmokingTimeCounter> {
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: screenHeight * 0.12,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MAIN_GREEN, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Sigarasız geçirdiğin süre",
            style: contentHeaderTextStyle,
          ),
          Text(
            context.watch<TimerProvider>().time,
            style: contentHeaderTextStyleBig,
          )
        ],
      ),
    );
  }
}
