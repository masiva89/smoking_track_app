import 'dart:developer';

class DateManipulation {
  DateTime getDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String dateTimeStringManipulation(String dateTime) {
    print(dateTime);
    final splittedDateTime = dateTime.split(" ");
    String date = splittedDateTime[0];
    String time = splittedDateTime[1];
    final splittedDate = date.split("-");
    final splittedTime = time.split(":");

    String day = splittedDate[2];
    String month = splittedDate[1];
    String year = splittedDate[0];

    String hour = splittedTime[0];
    String minute = splittedTime[1];
    String weekDay = whichDay(DateTime(int.parse(year), int.parse(month),
        int.parse(day), int.parse(hour), int.parse(minute)));

    return "$weekDay $hour:$minute";
  }

  String whichDay(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = now.add(const Duration(days: -1));
    final beforeYesterday = now.add(const Duration(days: -2));

    if (day == today.day && month == today.month && year == today.year) {
      return "Bugün";
    } else if (day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year) {
      return "Dün";
    } else if (day == beforeYesterday.day &&
        month == beforeYesterday.month &&
        year == beforeYesterday.year) {
      return "Evvelsi gün";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  DateTime stringToDateTime(
      {required int days,
      required int months,
      required int years,
      required int seconds,
      required int minutes,
      required int hours}) {
    return DateTime(years, months, days, hours, minutes, seconds);
  }
}
