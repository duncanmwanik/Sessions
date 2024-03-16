import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/toast.dart';
import '../../../_tables/_helpers/get_table_data.dart';

Future<void> createNewListItem(String listId, String itemName) async {
  try {
    String itemId = getUniqueId();
    Map itemData = {'t': itemName};

    Box box = Hive.box('${currentSelectedTable()}_lists');

    Map listData = box.get(listId);
    Map listItemData = listData['i'] ?? {};
    listItemData[itemId] = itemData;
    listData['i'] = listItemData;
    box.put(listId, listData);

    syncToCloud(tableId: currentSelectedTable(), where: 'lists', action: 'ic', itemId: itemId, listId: listId, isNew: true, data: {itemId: itemData});
  }
  //
  //
  //
  catch (e) {
    errorPrint('create-list-item', e);
    showToast(0, 'Could not create list item');
  }
}
