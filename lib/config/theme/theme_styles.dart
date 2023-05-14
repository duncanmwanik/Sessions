import 'package:flutter/material.dart';

import 'theme_constants.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      useMaterial3: true,
        primaryColor: isDarkTheme ? darkColor : lightColor,
        scaffoldBackgroundColor: isDarkTheme ? darkColor : lightColor,
        cardColor: isDarkTheme ? darkColor : lightColor,
        canvasColor: isDarkTheme ? darkColor : lightColor,
        shadowColor: Colors.grey,
        hintColor: Colors.black54,
        highlightColor: Colors.grey,
        hoverColor: Colors.grey,
        focusColor: Colors.orange,
        disabledColor: Colors.grey,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDarkTheme ? Colors.white54 : Colors.black54,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: isDarkTheme ? Colors.white : darkColor,
          unselectedItemColor: isDarkTheme ? Colors.white54 : darkColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: isDarkTheme ? Color(0xff2f2f2f) : Color(0xfff7f7f7),
          elevation: isDarkTheme ? 1 : 5,
          foregroundColor: isDarkTheme ? lightColor : darkColor,
        ),
        dividerTheme: DividerThemeData(
          color: isDarkTheme ? Colors.white12 : Colors.black12,
        ),
        fontFamily: "Roboto",
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: isDarkTheme ? lightColor : darkColor,
          selectionColor: isDarkTheme ? Colors.white : Colors.black,
          selectionHandleColor: isDarkTheme ? Colors.white : Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: isDarkTheme ? darkColor : lightColor,
              foregroundColor: isDarkTheme ? lightColor : darkColor,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white54 : Colors.black54,
        ),
        primaryIconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white54 : Colors.black54,
        ),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        dialogTheme:
            DialogTheme(backgroundColor: isDarkTheme ? darkColor : lightColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        appBarTheme: AppBarTheme(
          elevation: 0.1,
          backgroundColor: isDarkTheme ? Color(0xff1f1f1f) : Colors.white,
          foregroundColor: isDarkTheme ? Colors.white : Color(0xff1f1f1f),
        ),
        switchTheme: SwitchThemeData());
  }
}
