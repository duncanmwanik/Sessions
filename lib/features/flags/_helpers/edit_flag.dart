import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> editFlag(String newFlag, String color, String previousFlag) async {
  try {
    String tableId = currentSelectedTable();
    Hive.box('${currentSelectedTable()}_flags').put(newFlag, color);
    Hive.box('${currentSelectedTable()}_flags').delete(previousFlag);

    syncToCloud(tableId: tableId, where: 'flags', action: 'fe', isNew: true, flag: newFlag, color: color, data: {newFlag: color});
  } catch (e) {
    errorPrint('edit-flag', e);
  }
}
