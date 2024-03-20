import 'package:flutter/services.dart';

import '../../_config/styling/styling.dart';
import '../../_providers/_provider_variables.dart';
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

String getThemeImage(String themeImage) {
  return 'assets/images/$themeImage.jpg';
}

String getDefaultThemeImage() {
  return getThemeImage(themeProviderX.themeImage);
}

String getThemeType() {
  return settingBox.get('themeType', defaultValue: 'light');
}

bool getThemeAsBoolean(String theme) {
  bool isDarkTheme = false;

  if (theme == 'dark') {
    isDarkTheme = true;
  }
  if (theme == 'light') {
    isDarkTheme = false;
  }
  return isDarkTheme;
}
