import 'package:flutter/material.dart';

import '../variables/date_time_variables.dart';
import '../variables/provider_variables.dart';

String get12HourTimeFrom24HourTime(String time) {
  int hour24 = int.parse(time.split(':')[0]);
  String hour12 = ((hour24 > 12 || hour24 == 0) ? hours24to12[hour24] : hour24).toString();
  String period = hour24 >= 12 ? 'PM' : 'AM';
  String minute = int.parse(time.split(':')[1]).toString();

  // String hour = hour12.length == 2 ? hour12 : '0$hour12';
  minute = minute.length == 2 ? minute : '0$minute';

  return '$hour12:$minute $period';
}

String getWeekRange() {
  String month1 = months[dateTimeWatch.currentWeekDates[0].month - 1];
  String month2 = months[dateTimeWatch.currentWeekDates[6].month - 1];
  int day1 = dateTimeWatch.currentWeekDates[0].day;
  int day2 = dateTimeWatch.currentWeekDates[6].day;
  if (month1 == month2) {
    return '$month1 $day1-$day2';
  } else {
    return '$month1 $day1 - $month2 $day2';
  }
}

String getWeekDay() {
  int dayNo = dateTimeWatch.currentWeekDates[dateTimeWatch.selectedDate].weekday == 7
      ? 0
      : dateTimeWatch.currentWeekDates[dateTimeWatch.selectedDate].weekday;
  String day = weekDaysList[dayNo].dayName;
  String month = months[dateTimeWatch.currentWeekDates[dateTimeWatch.selectedDate].month - 1];
  int date = dateTimeWatch.currentWeekDates[dateTimeWatch.selectedDate].day;
  return '$day, $month $date';
}

List<DateTime> getCurrentWeekDates() {
  int today = DateTime.now().weekday;

  if (today == 1) {
    return [
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 3)),
      DateTime.now().add(Duration(days: 4)),
      DateTime.now().add(Duration(days: 5)),
    ];
  }
  if (today == 2) {
    return [
      DateTime.now().subtract(Duration(days: 2)),
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 3)),
      DateTime.now().add(Duration(days: 4)),
    ];
  }
  if (today == 3) {
    return [
      DateTime.now().subtract(Duration(days: 3)),
      DateTime.now().subtract(Duration(days: 2)),
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 3)),
    ];
  }
  if (today == 4) {
    return [
      DateTime.now().subtract(Duration(days: 4)),
      DateTime.now().subtract(Duration(days: 3)),
      DateTime.now().subtract(Duration(days: 2)),
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
    ];
  }
  if (today == 5) {
    return [
      DateTime.now().subtract(Duration(days: 5)),
      DateTime.now().subtract(Duration(days: 4)),
      DateTime.now().subtract(Duration(days: 3)),
      DateTime.now().subtract(Duration(days: 2)),
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
    ];
  }
  if (today == 6) {
    return [
      DateTime.now().subtract(Duration(days: 6)),
      DateTime.now().subtract(Duration(days: 5)),
      DateTime.now().subtract(Duration(days: 4)),
      DateTime.now().subtract(Duration(days: 3)),
      DateTime.now().subtract(Duration(days: 2)),
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
    ];
  }
  if (today == 7) {
    return [
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 3)),
      DateTime.now().add(Duration(days: 4)),
      DateTime.now().add(Duration(days: 5)),
      DateTime.now().add(Duration(days: 6)),
    ];
  }

  return [];
}
