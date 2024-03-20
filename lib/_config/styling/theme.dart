import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';

import 'styler.dart';
import 'styling.dart';

class AppTheme {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      primaryColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      scaffoldBackgroundColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      cardColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      canvasColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
      shadowColor: isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded,
      hintColor: isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded,
      highlightColor: isDarkTheme ? AppColors.darkHover : AppColors.lightHover,
      hoverColor: isDarkTheme ? AppColors.darkHover : AppColors.lightHover,
      focusColor: isDarkTheme ? AppColors.darkHover : AppColors.lightHover,
      disabledColor: isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded,
      bottomSheetTheme: BottomSheetThemeData(
        constraints: webMaxConstraints(),
      ),
      dialogTheme: DialogTheme(
        elevation: 0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: isDarkTheme ? AppColors.darkSecondary : AppColors.lightSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      ),
      timePickerTheme: TimePickerThemeData(
        elevation: 0,
        backgroundColor: isDarkTheme ? AppColors.darkSecondary : AppColors.lightSecondary,
        helpTextStyle: TextStyle(fontSize: textSizeSmall, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: textSizeAppBar,
          color: isDarkTheme ? AppColors.darkText : AppColors.lightText,
        ),
        backgroundColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightBar,
        foregroundColor: isDarkTheme ? AppColors.darkText : AppColors.lightText,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: isDarkTheme ? AppColors.darkBar : AppColors.lightBar,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: isDarkTheme ? AppColors.lightPrimary : AppColors.darkPrimary,
        unselectedItemColor: isDarkTheme ? AppColors.lightPrimary : AppColors.darkPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDarkTheme ? AppColors.darkBottomNavBarColor : AppColors.lightBottomNavBarColor,
        elevation: isDarkTheme ? 1 : 6,
        foregroundColor: isDarkTheme ? AppColors.lightPrimary : AppColors.darkPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
          foregroundColor: AppColors.accentHoverButton,
          textStyle: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusTiny)),
          shadowColor: AppColors.transparent,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDarkTheme ? AppColors.darkDividerColor : AppColors.lightDividerColor,
      ),
      fontFamily: 'Roboto',
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme ? AppColors.darkTextSelectionColor : AppColors.lightTextSelectionColor,
        selectionHandleColor: AppColors.darkTextSelectionColor,
      ),
      iconTheme: IconThemeData(
        color: isDarkTheme ? AppColors.darkText : AppColors.lightText,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDarkTheme ? AppColors.lightTertiary : AppColors.darkTertiary,
          borderRadius: BorderRadius.circular(borderRadiusTiny),
        ),
      ),
      primaryIconTheme: IconThemeData(color: isDarkTheme ? AppColors.lightTextFaded : AppColors.darkTextFaded),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      switchTheme: SwitchThemeData(),
    );
  }
}
