import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

class ListInputProvider with ChangeNotifier {
  // ---------- ---------- List Data Input ---------- ----------

  Map listInputData = {};
  Map previousListData = {};

  void updateAllInputData(Map data) {
    listInputData = getNewMapFrom(data);
    previousListData = getNewMapFrom(data);
    listInputData.remove('i');
    previousListData.remove('i');
    notifyListeners();
  }

  //

  void addToListInputData(String key, String value) {
    listInputData[key] = value;
    notifyListeners();
  }

  void removeFromListInputData(String key) {
    listInputData.remove(key);
    notifyListeners();
  }

  //

  void clearData() {
    listInputData.clear();
    previousListData.clear();
    notifyListeners();
  }
  //
}
