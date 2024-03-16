import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> deleteFlag(String flag) async {
  try {
    String tableId = currentSelectedTable();
    Hive.box('${currentSelectedTable()}_flags').delete(flag);
    syncToCloud(tableId: tableId, where: 'flags', action: 'fd', itemId: flag, flag: flag, isDelete: true, data: {});
  } catch (e) {
    errorPrint('delete-flag', e);
  }
}
