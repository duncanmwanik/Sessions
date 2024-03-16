import 'package:flutter/material.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../_providers/common_providers/datetime_provider.dart';
import '../../_variables/date_time_variables.dart';

String get12HourTimeFrom24HourTime(String time, {bool? islonger, bool showSeconds = false}) {
  // 'time' is in formart > '17:30' in 24 hour system
  int hour24 = getHour(time);
  String hour12 = ((hour24 > 12 || hour24 == 0) ? hours24to12ConversionMap[hour24] : hour24).toString();
  String period = hour24 >= 12 ? 'PM' : 'AM';
  String minute = getMinute(time).toString();
  String seconds = getSeconds(time).toString();

  minute = minute == '0' ? '' : ':$minute';
  seconds = seconds == '0' ? '' : ':$seconds';

  if (islonger == true) {
    minute = minute.length == 2 ? ':0${minute.substring(1)}' : minute;
    seconds = seconds.length == 2 ? ':0${seconds.substring(1)}' : seconds;
  }

  return showSeconds ? '$hour12$minute$seconds $period' : '$hour12$minute $period';
}

String getDateTimeFromTimeStamp(String timestamp) {
  // timestamp is a microsecondsSinceEpoch int
  return getDatePartFromDateTime(DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp)));
}

String getWeekDay(DateTimeProvider dateProvider) {
  int dayNo =
      dateProvider.currentWeekDates[DateTime.parse(dateProvider.selectedDate).weekday].weekday == 7 ? 0 : dateProvider.currentWeekDates[DateTime.parse(dateProvider.selectedDate).weekday].weekday;
  String day = weekDaysList[dayNo].name;
  String month = monthNamesList[dateProvider.currentWeekDates[DateTime.parse(dateProvider.selectedDate).weekday].month - 1];
  int date = dateProvider.currentWeekDates[DateTime.parse(dateProvider.selectedDate).weekday].day;
  return '$day, $month $date';
}

int getHour(String time) {
  try {
    return int.parse(time.toString().split(':')[0]);
  } catch (_) {
    return 0;
  }
}

int getMinute(String time) {
  try {
    return int.parse(time.toString().split(':')[1]);
  } catch (_) {
    return 0;
  }
}

int getSeconds(String time) {
  try {
    return int.parse(time.toString().split(':')[2]);
  } catch (_) {
    return 0;
  }
}

String getTimePartFromDateTime(String dateTime) {
  return dateTime.split(' ')[1];
}

String getTimePartFromTimeOfDay(var time) {
  try {
    if (time is TimeOfDay) {
      String hour = time.hour.toString();
      String minute = time.minute.toString();

      return '${hour.length == 1 ? '0$hour' : hour}:${minute.length == 1 ? '0$minute' : minute}:00';
    } else {
      String hour = time.toString().split(':')[0];
      String minute = time.toString().split(':')[1];
      return '${hour.length == 1 ? '0$hour' : hour}:${minute.length == 1 ? '0$minute' : minute}:00';
    }
  } catch (_) {
    return '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
  }
}

String getDatePartFromDateTime(var date) {
  try {
    return date is DateTime ? date.toString().split(' ')[0] : date.split(' ')[0];
  } catch (_) {
    return DateTime.now().toString().split(' ')[0];
  }
}

void updateSelectedDate(String newDate) {
  dateTimeProviderX.updateSelectedDate(newDate);
}

List<String> getDaysInBetweenRange(DateTime startDate, DateTime endDate, List weekdays) {
  List<String> dates = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    DateTime dateTime = startDate.add(Duration(days: i));
    String date = getDatePartFromDateTime(dateTime);
    int dateWeekdayNo = dateTime.weekday == 7 ? 0 : dateTime.weekday;

    if (weekdays.contains(dateWeekdayNo)) {
      if (!dates.contains(date)) {
        dates.add(date);
      }
    }
  }

  return dates;
}

bool isCurrentMonth(String date) {
  DateTime dateTime = DateTime.parse(date);
  return dateTime.month == dateTimeProviderX.selectedMonth;
}
