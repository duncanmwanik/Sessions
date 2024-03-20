import 'package:flutter/material.dart';

import '../../_helpers/_common_helpers/theme_helper.dart';
import '../../_services/hive/local_storage_service.dart';

class ThemeProvider with ChangeNotifier {
  String themeImage = settingBox.get('themeImage', defaultValue: 'mars');
  String themeType = settingBox.get('themeType', defaultValue: 'dark');

  void setThemeImage(String themeImage_, String themeType_) {
    themeImage = themeImage_;
    themeType = themeType_;
    settingBox.put('themeImage', themeImage_);
    settingBox.put('themeType', themeType_);
    changeStatusAndNavigationBarColor(themeType_);
    notifyListeners();
  }

  void enableThemeType() {
    changeStatusAndNavigationBarColor(themeType);
    notifyListeners();
  }
}
