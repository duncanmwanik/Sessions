import 'package:hive_flutter/hive_flutter.dart';

import '../../_services/cloud/sync_to_cloud.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import '../_common_helpers/global_helper.dart';

Future<void> editItemExtras({
  required String where,
  required String action,
  required String itemId,
  required String type,
  required String value,
}) async {
  try {
    String tableId = currentSelectedTable();

    bool isDelete = type.startsWith('d');
    String key = isDelete ? type.split('/')[1] : type;

    Box box = Hive.box('${tableId}_$where');
    Map itemData = box.get(itemId, defaultValue: {});
    if (isDelete) {
      itemData.remove(key);
    } else {
      itemData[key] = value;
    }

    await box.put(itemId, itemData);

    // addToPendingActions(tableId: tableId, where: where, action: action, itemId: itemId, isEdit: true, items: type, data: {type: value});
    syncToCloud(tableId: tableId, where: where, action: action, itemId: itemId, isEdit: true, editedItems: type, data: {key: value});
  } catch (e) {
    errorPrint('edit-item-extras', e);
  }
}
