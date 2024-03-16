import 'package:flutter/material.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';

class TableInputProvider with ChangeNotifier {
  //

  Map tableDetailsInput = {};
  Map previousTableData = {};

  void addToTableInputData(String key, String value) {
    tableDetailsInput[key] = value;
    notifyListeners();
  }

  void updateAllInputMap(Map data) {
    tableDetailsInput = getNewMapFrom(data);
    previousTableData = getNewMapFrom(data);
    notifyListeners();
  }

  // ---------- groups

  List selectedTableGroups = [];

  void updateSelectedTableGroups(String group) {
    if (selectedTableGroups.contains(group)) {
      selectedTableGroups.remove(group);
    } else {
      selectedTableGroups.add(group);
    }
    notifyListeners();
  }

  void clearSelectedTableGroups() {
    selectedTableGroups.clear();
    notifyListeners();
  }

  //

  void clearData() {
    tableDetailsInput.clear();
    selectedTableGroups.clear();
    previousTableData.clear();
    notifyListeners();
  }
}
