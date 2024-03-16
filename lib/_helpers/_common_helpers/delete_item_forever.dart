import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../_services/cloud/sync_to_cloud.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import 'global_helper.dart';

Future<void> deleteItemForever(BuildContext context, {required String where, required String action, required String itemId}) async {
  try {
    String tableId = currentSelectedTable();
    await Hive.box('${tableId}_$where').delete(itemId);

    syncToCloud(tableId: tableId, where: where, action: action, itemId: itemId, isDelete: true, data: {});
  } catch (e) {
    errorPrint('delete-item-forever-$where', e);
  }
}
