import 'package:flutter/material.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';

class SessionInputProvider with ChangeNotifier {
  // ---------- ---------- Sessions Data Input
  // stores session data input when creating new or editing one
  Map sessionInputData = {'t': '', 'a': '', 'l': '', 'v': '', 's': '', 'e': '', 'y': '0', 'c': '0', 'r': '30.m'};
  Map previousSessionData = {'t': '', 'a': '', 'l': '', 'v': '', 's': '', 'e': '', 'y': '0', 'c': '0', 'r': '30.m'};

  void addToSessionInputData(String key, String value) {
    sessionInputData[key] = value;
    notifyListeners();
  }

  void removeFromSessionInputData(String key) {
    sessionInputData.remove(key);
    notifyListeners();
  }

  // ----------

  void updateAllInputData(Map data) {
    sessionInputData = getNewMapFrom(data);
    previousSessionData = getNewMapFrom(data);
    notifyListeners();
  }

  // ----------

  int sessionInputDataDateMode = 0;

  void updateSessionInputDataDateMode(int value) {
    sessionInputDataDateMode = value;
    notifyListeners();
  }

  List sessionSelectedDates = [];

  void addToSessionSelectedDates(String newDate) {
    sessionSelectedDates.add(newDate);
    notifyListeners();
  }

  void removeFromSessionSelectedDates(String date) {
    if (sessionSelectedDates.contains(date)) {
      sessionSelectedDates.remove(date);
    }
    notifyListeners();
  }

  void clearSessionSelectedDates() {
    sessionSelectedDates.clear();
    notifyListeners();
  }

  void setSessionSelectedDates(List newDates) {
    sessionSelectedDates = newDates;
    notifyListeners();
  }

  String dateRangeStart = '';
  String dateRangeEnd = '';

  void updateDateRangeStart(String newDate) {
    dateRangeStart = newDate;
    notifyListeners();
  }

  void updateDateRangeEnd(String newDate) {
    dateRangeEnd = newDate;
    notifyListeners();
  }

  List dateRangeWeekDays = [];

  void addToDateRangeWeekDays(int weekday) {
    dateRangeWeekDays.add(weekday);
    notifyListeners();
  }

  void removeFromDateRangeWeekDays(int weekday) {
    dateRangeWeekDays.remove(weekday);
    notifyListeners();
  }
  // ----------

  void clearData() {
    sessionInputData = {'t': '', 'a': '', 'l': '', 'v': '', 's': '', 'e': '', 'y': '0', 'c': '0', 'r': '30.m'};
    previousSessionData = {'t': '', 'a': '', 'l': '', 'v': '', 's': '', 'e': '', 'y': '0', 'c': '0', 'r': '30.m'};
    sessionInputDataDateMode = 0;
    sessionSelectedDates.clear();
    notifyListeners();
  }
  //
  //
  //
}
