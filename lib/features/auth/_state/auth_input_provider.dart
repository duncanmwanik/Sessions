import 'package:flutter/material.dart';

class AuthInputProvider with ChangeNotifier {
  int selectedAuthView = 0;

  void updateSelectedAuthView(int view) {
    selectedAuthView = view;
    notifyListeners();
  }
}
