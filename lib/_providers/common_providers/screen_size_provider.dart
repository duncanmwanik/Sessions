import 'package:flutter/material.dart';

class ScreenSizeProvider with ChangeNotifier {
  //
  // Width fot bottom sheets
  //
  double sheetWidth = 0;

  void updateSheetWidth(double width) {
    sheetWidth = width;
    notifyListeners();
  }
}
