import 'package:flutter/material.dart';

import '../../_services/hive/local_storage_service.dart';
import '../../features/_tables/_helpers/get_table_data.dart';

class LayoutProvider with ChangeNotifier {
  // ---------- layout
  String layoutNotes = globalBox.get('${currentSelectedTable()}_layoutNotes', defaultValue: 'grid');
  String layoutBoard = globalBox.get('${currentSelectedTable()}_layoutBoards', defaultValue: 'column');

  void updateLayout(String type, String value) {
    if (type == 'notes') {
      layoutNotes = value;
      globalBox.put('${currentSelectedTable()}_layoutNotes', value);
    }
    if (type == 'lists') {
      layoutBoard = value;
      globalBox.put('${currentSelectedTable()}_layoutBoards', value);
    }
    notifyListeners();
  }
}
