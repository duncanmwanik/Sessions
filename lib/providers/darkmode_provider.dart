import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';

class DarkThemeProvider with ChangeNotifier {
  bool isDarkTheme = localStorage.getBool("isDarkTheme") ?? false;

  void enableDarkTheme(bool value) {
    isDarkTheme = value;
    localStorage.setBool("isDarkTheme", value);
    notifyListeners();
  }
}
