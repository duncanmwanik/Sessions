import '../../../_services/cloud/checks.dart';
import '../../../_services/hive/local_storage_service.dart';

List getGroupNamesAsList(Map userTables) {
  List groupNames = List.generate(userTables.keys.length, (index) {
    if (!userTables.keys.toList()[index].toString().startsWith('table')) {
      return userTables.keys.toList()[index].toString();
    }
  });

  List groupNamesNoNulls = [];

  for (var element in groupNames) {
    if (element != null) {
      groupNamesNoNulls.add(element);
    }
  }

  return groupNamesNoNulls;
}

Future<void> saveTablesNamesToLocalStorage(Map userTables) async {
  userTables.forEach((key, value) async {
    if (key.toString().startsWith('table')) {
      await doesTableExist(key).then((tableName) {
        if (tableName != 'none') {
          tableNamesBox.put(key, tableName);
        }
      });
    } else if (!key.toString().startsWith('table')) {
      Map groupTables = value as Map;
      groupTables.forEach((key, value) async {
        if (key.toString().startsWith('table')) {
          await doesTableExist(key).then((tableName) {
            if (tableName != 'none') {
              tableNamesBox.put(key, tableName);
            }
          });
        }
      });
    }
  });
}
