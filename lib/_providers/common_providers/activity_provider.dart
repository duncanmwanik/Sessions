import 'package:flutter/material.dart';

class ActivityProvider with ChangeNotifier {
  String currentTimestamp = 'none';
  String currentActivity = 'none';

  void updateCurrentActivity(String timestamp, String activity) {
    currentTimestamp = timestamp;
    currentActivity = activity;
    notifyListeners();
  }
}
