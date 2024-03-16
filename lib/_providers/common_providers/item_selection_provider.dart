import 'package:flutter/material.dart';

class ItemSelectionProvider with ChangeNotifier {
// ---------- selected item list
  Map selectedItemMap = {};

  void addToSelectedItemMap(String id, String title, bool isPinned, String type) {
    selectedItemMap[id] = {'isPinned': isPinned, 'title': title, 'type': type};
    notifyListeners();
  }

  void removeFromSelectedItemMap(String id) {
    selectedItemMap.remove(id);
    notifyListeners();
  }

  void clearAnyItemSelections() {
    selectedItemMap.clear();
    notifyListeners();
  }
}
