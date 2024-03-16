import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

import '../../../_helpers/user/user_info.dart';
import '../../../_services/hive/local_storage_service.dart';
import 'get_table_data.dart';

bool isThereATableSelected() {
  return currentSelectedTable() != 'none';
}

Future<String> getTableNameFuture(String tableId) async {
  if (tableNamesBox.containsKey(tableId)) {
    return tableNamesBox.get(tableId);
  } else {
    String tableName = await getTableNameFromCloud(tableId);
    return tableName;
  }
}

String validateTableInput(String? name) {
  if (name == null || name.trim().isEmpty) {
    return 'Enter table name';
  } else {
    return '';
  }
}

bool isTableAdmin() {
  try {
    if (currentSelectedTable() != 'none') {
      return Hive.box('${currentSelectedTable()}_admins').containsKey(getCurrentUserId());
    } else {
      return false;
    }
  } catch (e) {
    errorPrint('isTableAdmin', e);
    return false;
  }
}

Future<bool> isTableOwner(String tableId) async {
  try {
    Box box = await Hive.openBox('${tableId}_info');
    return box.get('o', defaultValue: 'none') == getCurrentUserId();
  } catch (e) {
    return false;
  }
}

bool isTableAlreadyAdded(String tableId) {
  try {
    return userDataBox.containsKey(tableId);
  } catch (e) {
    return false;
  }
}

bool isTableOpened(String tableId) {
  try {
    return Hive.box('${tableId}_info').isOpen;
  } catch (e) {
    return false;
  }
}
