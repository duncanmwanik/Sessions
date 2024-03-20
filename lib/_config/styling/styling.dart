import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

import 'helpers.dart';

class AppColors {
  static const Color accent = Colors.red;

  static Color accentHoverButton = Colors.grey;

  static const Color cursorColor = Colors.lightBlueAccent;

  static const Color transparent = Colors.transparent;

  static Color fabColor = accent;

  static const Color darkPrimary = Color(0xff1b1d1c);
  static const Color lightPrimary = Color(0xfffafafc);

  static const Color darkSecondary = Color(0xff272829);
  static const Color lightSecondary = Color(0xfff1f1f2);

  static const Color darkTertiary = Color(0xff282a29);
  static const Color lightTertiary = lightSecondary;

  static Color lightHover = Colors.grey.withOpacity(0.2);
  static Color darkHover = Colors.grey.withOpacity(0.1);

  static const Color darkBar = Color(0xff212529);
  static const Color lightBar = Colors.white;

  static const Color darkText = Colors.white;
  static const Color lightText = Color(0xff333333);

  static Color darkTextFaded = Colors.white.withOpacity(0.7);
  static Color lightTextFaded = Color(0xff333333).withOpacity(0.8);

  static const Color darkDividerColor = Colors.white12;
  static const Color lightDividerColor = Colors.black12;

  static const Color darkBottomNavBarColor = Color(0xff2f2f2f);
  static const Color lightBottomNavBarColor = Color(0xfff7f7f7);

  static Color darkTextSelectionColor = accent;
  static Color lightTextSelectionColor = accent;

  static List<Color> toastColors = [Colors.red, Colors.green, Colors.blue];
}

class CustomAppColors {
  bool isDarkTheme = false;

  void setTheme(bool value) {
    isDarkTheme = value;
  }

  //
  // -------------------------- Primary Colors
  //
  Color black = Colors.black;
  Color white = Colors.white;
  Color transparent = Colors.transparent;

  Color accentColor() {
    return AppColors.accent;
  }

  Color primaryColor() {
    return isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary;
  }

  Color secondaryColor({bool inverted = false}) {
    if (inverted) {
      return isDarkTheme ? AppColors.lightSecondary : AppColors.darkSecondary;
    } else {
      return isDarkTheme ? AppColors.darkSecondary : AppColors.lightSecondary;
    }
  }

  Color tertiaryColor() {
    return isDarkTheme ? AppColors.darkTertiary : AppColors.lightTertiary;
  }

  Color fabColor() {
    return isDarkTheme ? white : Color(0xff3f3f3f);
  }

  Color buttonColor() {
    return appColor(1.5);
  }

  Color itemColor({bool isDialog = false, String? bgColor}) {
    if (isDarkTheme) {
      return isDialog
          ? Colors.white10
          : hasBGColor(bgColor)
              ? Color(0xffededed)
              : Color(0xff343a40);
    } else {
      return Color(0xfff1f3f5);
    }
  }

  Color appColor(double weight) {
    return Colors.grey.withOpacity(weight / 10);
  }

  Color menuColor() {
    return isDarkTheme ? Color(0xff343434) : Color(0xfff5f5f5);
  }

  //
  // -------------------------- Text Colors
  //
  Color textColor({bool inverted = false}) {
    if (inverted) {
      return AppColors.lightText;
    } else {
      return isDarkTheme ? AppColors.darkText : AppColors.lightText;
    }
  }

  Color textColorFaded({bool inverted = false}) {
    if (inverted) {
      return AppColors.lightTextFaded;
    } else {
      return isDarkTheme ? AppColors.darkTextFaded : AppColors.lightTextFaded;
    }
  }

  Color invertedTextColor() {
    return isDarkTheme ? AppColors.lightText : AppColors.darkText;
  }

  //
  // -------------------------- Other Colors
  //
  Color tooltipColor() {
    return isDarkTheme ? AppColors.lightTertiary : AppColors.darkTertiary;
  }

  Color dialogButtonColor({bool isCancel = false}) {
    return isCancel
        ? isDarkTheme
            ? Colors.white12
            : Colors.black38
        : AppColors.accent;
  }

  Color borderColor() {
    return Colors.grey.withOpacity(0.2);
  }

  Color chatBubbleColor({bool isSent = false}) {
    if (isSent) {
      return isDarkTheme ? Colors.grey.shade100 : Colors.grey.shade200;
    } else {
      return isDarkTheme ? Colors.green.shade100 : Colors.green.shade100;
    }
  }

  Color listItemColor({bool inverted = false}) {
    if (inverted) {
      return Color(0xfffbfbfb);
    } else {
      return isDarkTheme ? Colors.white10 : white;
    }
  }

  Color fileColor(String fileExtension) {
    if (['jpg', 'png', 'jpeg', 'jfif'].contains(fileExtension)) {
      return accentColor();
    } else if (['pdf'].contains(fileExtension)) {
      return Colors.redAccent;
    } else {
      return Colors.deepOrange;
    }
  }

  Color reminderOverviewColor([String? bgColor]) {
    if (hasBGColor(bgColor)) {
      return Colors.black12;
    } else {
      return isDarkTheme ? Colors.white10 : Colors.black12;
    }
  }

  Color toastBackgroundColor() {
    return isDarkTheme ? Colors.white : Colors.white;
  }

  Color sessionItemColor() {
    return isDarkTheme ? Color(0xfffefefe) : Color(0xff404040);
  }

  //
  // -------------------------- Shadows
  //
  List<BoxShadow>? webLightBoxShadow() {
    return isDarkTheme
        ? null
        : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0.5),
            )
          ];
  }

  List<BoxShadow>? listItemShadow({bool inverted = false}) {
    List<BoxShadow> shadow = [BoxShadow(color: Colors.grey.withOpacity(0.7), spreadRadius: 0.5)];

    return inverted || isDarkTheme ? null : shadow;
  }

  List<BoxShadow>? itemShadow([bool isHovered = true]) {
    return [
      BoxShadow(
        color: isHovered
            ? isDarkTheme
                ? Colors.white10
                : Colors.black12
            : styler.transparent,
        spreadRadius: styler.isDarkTheme ? 1 : 1.5,
        blurRadius: styler.isDarkTheme ? 1.5 : 2,
        offset: Offset(0, 0),
      )
    ];
  }

  //
  // -------------------------- Borders
  //
  BorderSide lightTableBorder() {
    return BorderSide(color: Colors.grey.withOpacity(isDarkTheme ? 0.15 : 0.4));
  }

  BoxBorder? itemBorder(bool isSelected, {bool hasBgColor = false}) {
    if (isSelected) {
      return Border.all(color: accentColor(), width: 0.5);
    } else {
      return null;
      //   return Border.all(
      //       width: 0.1,
      //       color: hasBgColor
      //           ? styler.transparent
      //           : isDarkTheme
      //               ? Colors.grey.withOpacity(0.2)
      //               : Colors.grey.withOpacity(0.4));
    }
  }

  BorderSide? lightButtonBorder() {
    return isDarkTheme ? null : BorderSide(color: Colors.grey.withOpacity(0.1));
  }
}
