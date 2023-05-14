import 'package:flutter/material.dart';
import '../helpers/datetime_helper.dart';

class DateTimeProvider with ChangeNotifier {
  String selectedDate = DateTime.now().toString().split(' ')[0];

  void selectNewDate(String date) {
    selectedDate = date;
    notifyListeners();
  }

  final List<DateTime> _currentWeekDates = getCurrentWeekDates();

  List<DateTime> get currentWeekDates {
    return _currentWeekDates;
  }
}
