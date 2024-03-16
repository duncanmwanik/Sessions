import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> addFlag(String flag, String color) async {
  try {
    String tableId = currentSelectedTable();
    Hive.box('${currentSelectedTable()}_flags').put(flag, color);

    syncToCloud(tableId: tableId, where: 'flags', action: 'fc', isNew: true, itemId: flag, flag: flag, color: color, data: {flag: color});
  } catch (e) {
    errorPrint('add-flag', e);
  }
}
