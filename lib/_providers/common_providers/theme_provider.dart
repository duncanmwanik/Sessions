import 'package:flutter/material.dart';

import '../../_helpers/_common_helpers/theme_helper.dart';
import '../../_services/hive/local_storage_service.dart';

class ThemeProvider with ChangeNotifier {
  String isDarkTheme = getTheme();

  void enableDarkTheme(String theme) {
    isDarkTheme = theme;
    settingBox.put('theme', theme);
    changeStatusAndNavigationBarColor(theme);
    notifyListeners();
  }
}
