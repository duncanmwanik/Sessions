import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/user/user_info.dart';
import '../../../../_services/cloud/checks.dart';
import '../../../../_services/hive/local_storage_service.dart';

String getLastTableActivityVersion(String tableId) {
  return tableActivityVersionBox.get(tableId, defaultValue: 'none');
}

Future<String> getTableNameFromCloud(String tableId) async {
  String tableName = await doesTableExist(tableId);
  if (tableName != 'none') {
    tableNamesBox.put(tableId, tableName);
    printThis('Gotten table name for $tableId : $tableName');
    return tableName;
  } else {
    return '---';
  }
}

String currentSelectedTable() {
  return globalBox.get('${getCurrentUserId()}_currentTableId', defaultValue: 'none');
}

String getTableName(String tableId) {
  return tableNamesBox.get(tableId, defaultValue: 'No Name');
}

String? getCurrentTableName() {
  return tableNamesBox.get(currentSelectedTable(), defaultValue: null);
}
