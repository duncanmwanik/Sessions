import 'package:flutter/material.dart';

class FlagInputProvider with ChangeNotifier {
// ---------- flag list
  List flagList = [];

  void addToFlagList(String value) {
    flagList.add(value);
    notifyListeners();
  }

  void removeFromFlagList(String value) {
    flagList.remove(value);
    notifyListeners();
  }

  void updateFlagList(List value) {
    flagList = value;
    notifyListeners();
  }

  //
  String selectedFlagColor = '0';

  void updateSelectedFlagColor(String color) {
    selectedFlagColor = color;
    notifyListeners();
  }
}
