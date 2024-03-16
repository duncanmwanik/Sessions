import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

import 'helpers.dart';

class AppColors {
  static const Color accent = Colors.blue;

  static Color accentHoverButton = Colors.grey;

  static Color lightHover = Colors.grey.shade200;
  static Color darkHover = Colors.grey.withOpacity(0.1);

  static const Color cursorColor = Colors.lightBlueAccent;

  static const Color transparent = Colors.transparent;

  static Color fabColor = Colors.blueGrey;

  static const Color darkPrimary = Color(0xff212529);
  static const Color lightPrimary = Colors.white;

  static const Color darkSecondary = Color(0xff343a40);
  static Color lightSecondary = Colors.white;

  static const Color darkBar = Color(0xff212529);
  static const Color lightBar = Colors.white;

  static const Color darkTertiary = Color(0xff495057);

  static const Color darkText = Colors.white;
  static const Color lightText = Color(0xff333333);

  static const Color darkTextFaded = Colors.white54;
  static const Color lightTextFaded = Color(0xff686b6e);

  static const Color darkDividerColor = Colors.white12;
  static const Color lightDividerColor = Colors.black12;

  static const Color darkBottomNavBarColor = Color(0xff2f2f2f);
  static const Color lightBottomNavBarColor = Color(0xfff7f7f7);

  static Color darkTextSelectionColor = Colors.blue;
  static Color lightTextSelectionColor = Colors.blue.shade100;

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

  Color secondaryColor() {
    return isDarkTheme ? AppColors.darkSecondary : AppColors.lightSecondary;
  }

  Color tertiaryColor() {
    return isDarkTheme ? AppColors.darkTertiary : white;
  }

  Color fabColor() {
    return isDarkTheme ? white : Color(0xff3f3f3f);
  }

  Color hoverColor() {
    return isDarkTheme ? AppColors.darkHover : AppColors.lightHover;
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

  //
  // -------------------------- Text Colors
  //
  Color textColor([String? bgColor]) {
    if (hasBGColor(bgColor)) {
      return Colors.black87;
    } else {
      return isDarkTheme ? AppColors.darkText : AppColors.lightText;
    }
  }

  Color textColorFaded([String? bgColor]) {
    if (hasBGColor(bgColor)) {
      return Colors.black87;
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

  Color appbarColor() {
    return AppColors.darkSecondary.withOpacity(isDarkTheme ? 0.3 : 0.05);
  }

  Color tooltipColor() {
    return isDarkTheme ? AppColors.lightPrimary : AppColors.darkTertiary;
  }

  Color dialogButtonColor({bool isCancel = false}) {
    return isCancel
        ? isDarkTheme
            ? Colors.white12
            : Colors.black38
        : Colors.blue.shade500;
  }

  Color borderColor([String? bgColor]) {
    return Colors.blueGrey.withOpacity(0.2);
  }

  Color chatBubbleColor({bool isSent = false}) {
    if (isSent) {
      return isDarkTheme ? Colors.grey.shade100 : Colors.grey.shade200;
    } else {
      return isDarkTheme ? Colors.green.shade100 : Colors.green.shade100;
    }
  }

  Color listItemColor([String? bgColor]) {
    if (hasBGColor(bgColor)) {
      return Color(0xfffbfbfb);
    } else {
      return isDarkTheme ? Colors.white10 : white;
    }
  }

  Color fileColor(String fileExtension) {
    if (['jpg', 'png', 'jpeg', 'jfif'].contains(fileExtension)) {
      return Colors.blueAccent;
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

  Color hoverActionsColor([String? bgColor]) {
    if (hasBGColor(bgColor)) {
      return Colors.black87;
    } else {
      return isDarkTheme ? Color(0xffeeeeee) : Color(0xff505050);
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

  List<BoxShadow>? listItemShadow([String? bgColor]) {
    List<BoxShadow> shadow = [BoxShadow(color: Colors.grey.withOpacity(0.7), spreadRadius: 0.5)];

    return hasBGColor(bgColor) || isDarkTheme ? null : shadow;
  }

  List<BoxShadow>? itemShadow([bool isHovered = true]) {
    return [
      BoxShadow(
        color: isHovered
            ? styler.isDarkTheme
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
  BoxBorder? lightBoxBorder() {
    return isDarkTheme ? null : Border.all(color: Colors.blueGrey.withOpacity(0.3));
  }

  BorderSide lightTableBorder() {
    return BorderSide(color: Colors.grey.withOpacity(isDarkTheme ? 0.1 : 0.3));
  }

  BoxBorder? itemBorder(bool isSelected, {bool hasBgColor = false}) {
    if (isSelected) {
      return Border.all(color: accentColor(), width: 1);
    } else {
      return Border.all(
          color: hasBgColor
              ? styler.transparent
              : isDarkTheme
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.4));
    }
  }

  BorderSide? lightButtonBorder() {
    return isDarkTheme ? BorderSide.none : BorderSide(color: borderColor());
  }
}