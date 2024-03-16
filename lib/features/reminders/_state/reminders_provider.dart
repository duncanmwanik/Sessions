import 'package:flutter/material.dart';

import '../../../_helpers/date_time/datetime_helper.dart';

class ReminderProvider with ChangeNotifier {
  // ----------
  String date = '';
  String time = '';

  void updateDate(String newDate) {
    date = newDate;
    notifyListeners();
  }

  void updateTime(String newTime) {
    time = newTime;
    notifyListeners();
  }

  void updateBothDateAndTime(String? reminder) {
    if (reminder != null && reminder.isNotEmpty) {
      date = getDatePartFromDateTime(reminder);
      time = getTimePartFromDateTime(reminder);
    } else {
      date = '';
      time = '';
    }
    notifyListeners();
  }

  // ----------

  void clearData() {
    date = '';
    time = '';
    notifyListeners();
  }
}
