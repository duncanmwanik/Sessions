import 'package:sessions/_providers/_provider_variables.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../new_table/table_sheet.dart';

void prepareTableForCreation() {
  tableInputProviderX.clearData();
  showTableBottomSheet(isNewTable: true);
}

void prepareTableForEdit(Map tableData) {
  tableInputProviderX.updateAllInputMap(tableData);
  print(tableInputProviderX.tableDetailsInput);
  print(tableInputProviderX.previousTableData);
  showTableBottomSheet(isNewTable: false);
}

void clearTableInput(dynamic clearTable) {
  if (clearTable == true) {
    tableInputProviderX.clearData();
  }
}

List<String> getGroupNames() {
  List<String> groupNames = [];
  Map userTables = userDataBox.toMap();
  userTables.forEach((key, value) {
    if (!key.startsWith('table')) {
      if (!groupNames.contains(key)) {
        groupNames.add(key);
      }
    }
  });

  return groupNames;
}
