import 'package:flutter/material.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../_tables/_helpers/get_table_data.dart';

class LabelsProvider with ChangeNotifier {
  //

  List selectedLabelList = [];

  void addToLabelList(String value) {
    selectedLabelList.add(value);
    notifyListeners();
  }

  void removeFromLabelList(String value) {
    selectedLabelList.remove(value);
    notifyListeners();
  }

  void updateLabelList(List value) {
    selectedLabelList = value;
    notifyListeners();
  }

  //

  String selectedLabel = globalBox.get('${currentSelectedTable()}_selected_label', defaultValue: 'All');

  void updateSelectedLabel(String label) {
    selectedLabel = label;
    globalBox.put('${currentSelectedTable()}_selected_label', label);
    notifyListeners();
  }
  //
}
