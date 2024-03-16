import 'package:flutter/material.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';

class ListItemInputProvider with ChangeNotifier {
  //

  String itemId = '';
  String listId = '';
  Map listItemData = {};
  Map previousListItemData = {};

  //

  void updateAllInputData(String itemId_, String listid_, Map data) {
    itemId = itemId_;
    listId = listid_;
    listItemData = getNewMapFrom(data);
    previousListItemData = getNewMapFrom(data);
    notifyListeners();
  }

  //

  void addToListItemData(String key, String value) {
    listItemData[key] = value;
    notifyListeners();
  }

  void removeFromListItemData(String key) {
    listItemData.remove(key);
    notifyListeners();
  }

  void clearData(Map data) {
    listItemData.clear();
    previousListItemData.clear();
    notifyListeners();
  }

  //

  String miniEditsItemId = 'none';

  void updateMiniEditsItemId(String itemId) {
    miniEditsItemId = itemId;
    notifyListeners();
  }

  //
}
