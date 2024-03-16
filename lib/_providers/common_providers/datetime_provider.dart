import 'package:flutter/material.dart';

import '../../_helpers/date_time/datetime_helper.dart';
import '../../_helpers/date_time/get_current_week_dates.dart';
import '../../_helpers/date_time/month_helper.dart';

class DateTimeProvider with ChangeNotifier {
  String selectedDate = getDatePartFromDateTime(DateTime.now());

  void updateSelectedDate(String date) {
    selectedDate = date;
    notifyListeners();
  }

  int selectedMonth = DateTime.now().month;

  int selectedYear = DateTime.now().year;

  void updateSelectedYear(int year) {
    selectedYear = year;
    notifyListeners();
  }

  void changeSelectedMonth(int month) {
    selectedMonth = month;
    notifyListeners();
  }

  void updateSelectedMonth(String how) {
    if (how == 'inc') {
      if (selectedMonth >= 12) {
        selectedMonth = 1;
        selectedYear++;
      } else {
        selectedMonth++;
      }
    } else {
      if (selectedMonth <= 1) {
        selectedMonth = 12;
        selectedYear--;
      } else {
        selectedMonth--;
      }
    }
    notifyListeners();
  }

  Map<int, String> monthDatesMap = getMonthDateMap(DateTime.now().year, DateTime.now().month);

  Future<void> updateMonthDatesMap() async {
    monthDatesMap = getMonthDateMap(selectedYear, selectedMonth);
    notifyListeners();
  }

  List<DateTime> currentWeekDates = getCurrentWeekDates(DateTime.now());

  void updateCurrentWeekDates(DateTime newDate) {
    currentWeekDates = getCurrentWeekDates(newDate);
    notifyListeners();
  }
}
