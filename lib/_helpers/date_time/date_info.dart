import 'package:sessions/_providers/_provider_variables.dart';

import '../../_variables/date_time_variables.dart';

String getDayInfo(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;
    int number = dateTime.weekday == 7 ? 0 : dateTime.weekday;

    return isCurrentYear
        ? '${weekDaysList[number].shortName} . ${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}'
        : '${weekDaysList[number].shortName} . ${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

String getDayInfoFullNames(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;
    int number = dateTime.weekday == 7 ? 0 : dateTime.weekday;

    return isCurrentYear
        ? '${weekDaysList[number].name}, ${monthNamesList[dateTime.month - 1]} ${dateTime.day}'
        : '${weekDaysList[number].name}, ${monthNamesList[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

String getWeekInfo(DateTime startDate, DateTime endDate) {
  bool isSameYear = startDate.year == endDate.year;
  bool isSameMonth = startDate.month == endDate.month;

  if (isSameYear) {
    if (isSameMonth) {
      return '${monthNamesListShort[startDate.month - 1]} ${startDate.year}';
    } else {
      return '${monthNamesListShort[startDate.month - 1]} - ${monthNamesListShort[endDate.month - 1]} ${startDate.year}';
    }
  } else {
    return '${monthNamesListShort[startDate.month - 1]} ${startDate.year} - ${monthNamesListShort[endDate.month - 1]} ${endDate.year}';
  }
}

String getMonthInfo(int year, int month) {
  // if (year == DateTime.now().year) {
  //   return monthNamesListShort[month - 1];
  // }
  return '${monthNamesListShort[month - 1]} $year';
}

String getDateInfo(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;
    int number = dateTime.weekday == 7 ? 0 : dateTime.weekday;

    return isCurrentYear
        ? '${weekDaysList[number].shortName}, ${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}'
        : '${weekDaysList[number].shortName}, ${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

String getDateInfoForReminder(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    bool isCurrentYear = dateTime.year == DateTime.now().year;

    return isCurrentYear ? '${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}' : '${monthNamesListShort[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (e) {
    return date;
  }
}

class DateInfo {
  DateInfo({required this.dateTime});

  final String dateTime;

  var now = DateTime.now();

  DateTime date() {
    return DateTime.parse(dateTime);
  }

  int day() {
    return date().day;
  }

  int month() {
    return date().month;
  }

  int year() {
    return date().year;
  }

  bool isToday() {
    return date().day == now.day && date().month == now.month && date().year == now.year;
  }

  bool isCurrentMonth() {
    return dateTimeProviderX.selectedMonth == now.month && dateTimeProviderX.selectedYear == now.year;
  }

  bool isCurrentYear() {
    return dateTimeProviderX.selectedYear == now.year;
  }

  String dayString() {
    return date().day.toString();
  }

  String weekday() {
    int number = date().weekday == 7 ? 0 : date().weekday;

    return weekDaysList[number].shortName;
  }
}
