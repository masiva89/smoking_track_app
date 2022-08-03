import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_projects/core/date_manipulation.dart';
import 'dart:async';

import 'package:flutter_projects/features/dashboard/service/dashboard_service.dart';

class TimerProvider extends ChangeNotifier {
  late Timer timer;
  final DashboardService _dashboardService = DashboardService();
  int _minutes = 0;
  int _hours = 0;
  int _seconds = 0;
  String get time => "$_hours:$_minutes:$_seconds";

  TimerProvider({required bool isOpening}) {
    startTimer(isOpening: isOpening);
  }

  Future<void> saveTimeToDatabase() async {
    final date = DateTime.parse(
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} $_hours:$_minutes:$_seconds");
    _dashboardService.saveTime(dateTime: date).then((value) {
      log("time saved");
    });
  }

  void startTimer({required bool isOpening}) {
    log("isOpening: ${isOpening.toString()}");
    if (!isOpening) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
        }
        if (_minutes == 60) {
          _minutes = 0;
          _hours++;
        }
        DateTime date = DateManipulation().stringToDateTime(
            days: DateTime.now().day,
            months: DateTime.now().month,
            years: DateTime.now().year,
            seconds: _seconds,
            minutes: _minutes,
            hours: _hours);
        if (_seconds % 5 == 0) {
          _dashboardService.saveTime(dateTime: date);
        }
        notifyListeners();
      });
    } else {
      final lastSmokingTimeMap = _dashboardService.getLastSmokingTime();
      lastSmokingTimeMap.then((value) {
        if (value != null) {
          final dbDate = DateManipulation().stringToDateTime(
              days: value["days"],
              months: value["months"],
              years: value["years"],
              seconds: value["seconds"],
              minutes: value["minutes"],
              hours: value["hours"]);
          log("db date: ${dbDate.toString()}");
          DateTime nowDate = DateTime.now();
          log("now: ${nowDate.toString()}");
          final difference = nowDate.difference(dbDate);
          log("difference in seconds: ${difference.inSeconds}");
          log("difference in minutes: ${difference.inMinutes}");
          log("difference in hours: ${difference.inHours}");
          _hours = difference.inHours;
          _minutes = difference.inMinutes - _hours * 60;
          _seconds = difference.inSeconds - _hours * 60 * 60 - _minutes * 60;
          startTimer(isOpening: false);
          notifyListeners();
        }
      });
    }
  }

  set counter(int value) {
    _seconds = value;
    notifyListeners();
  }

  void resetTimer() {
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    notifyListeners();
  }
}


//uygulamayı baştan açınca db deki veriyi çek. (son sigara içme zamanı(add_button tapping) )
//o anki datetime ile db deki datetime ın farkını al.
//o farkının saat, dakika, saniye olarak hesaplandığını göster.
//bunu provider'a işle.
