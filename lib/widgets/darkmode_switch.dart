import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/darkmode_provider.dart';

Widget darkModeSwitch() {
  return Consumer<DarkThemeProvider>(builder: (context, appTheme, child) {
    return CupertinoSwitch(
      activeColor: Colors.orange,
      value: appTheme.isDarkTheme,
      onChanged: (value) {
        appTheme.enableDarkTheme(value);
      },
    );
  });
}
