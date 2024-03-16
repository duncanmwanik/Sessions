import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../../_config/styling/styling.dart';
import '../../_services/hive/local_storage_service.dart';

void changeStatusAndNavigationBarColor(String theme) {
  bool isDarkTheme = getThemeAsBoolean(theme);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDarkTheme ? AppColors.darkBar : AppColors.lightBar,
      statusBarColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightBar,
    ),
  );
}

bool getSystemTheme() {
  var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  return brightness == Brightness.dark;
}

String getTheme() {
  return settingBox.get('theme', defaultValue: 'system');
}

bool getThemeAsBoolean(String theme) {
  bool isDarkTheme = false;

  if (theme == 'system') {
    isDarkTheme = getSystemTheme();
  }
  if (theme == 'dark') {
    isDarkTheme = true;
  }
  if (theme == 'light') {
    isDarkTheme = false;
  }
  return isDarkTheme;
}
