import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/edits/compare_data.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/toast.dart';
import '../../../_tables/_helpers/get_table_data.dart';
import '../../../files/_helpers/upload_files.dart';

Future<void> editListItem(Map editedItemData, Map previousItemData) async {
  try {
    // if there are changes made
    if (!DeepCollectionEquality().equals(editedItemData, previousItemData)) {
      String tableId = currentSelectedTable();
      String itemId = listItemInputProviderX.itemId;
      String listId = listItemInputProviderX.listId;

      Map comparedData = compareData(type: 'listItems', previousData: previousItemData, editedData: editedItemData);
      String editedItems = comparedData['editedItems'];
      Map validatedData = comparedData['validatedData'];

      if (editedItems.isNotEmpty) {
        Box box = Hive.box('${currentSelectedTable()}_lists');
        Map listData = box.get(listId);
        Map listItemData = listData['i'] ?? {};
        listItemData[itemId] = validatedData;
        listData['i'] = listItemData;
        box.put(listId, listData);

        handleFilesCloud(tableId, validatedData, items: editedItems);
        syncToCloud(tableId: tableId, where: 'lists', action: 'ie', itemId: itemId, listId: listId, isEdit: true, editedItems: editedItems, data: validatedData);
      }
    }
  } catch (e) {
    errorPrint('edit-list-item', e);
    showToast(0, 'Could not edit list item');
  }
}

Future<void> editListItemSingleKey(String itemId, String listId, String type, String value) async {
  try {
    bool isDelete = type.startsWith('d');
    String key = isDelete ? type.split('/')[1] : type;

    Box box = Hive.box('${currentSelectedTable()}_lists');

    Map listData = box.get(listId);
    Map listItemData = listData['i'] ?? {};
    Map itemData = listItemData[itemId] ?? {};
    if (isDelete) {
      itemData.remove(key);
    } else {
      itemData[key] = value;
    }
    listItemData[itemId] = itemData;
    listData['i'] = listItemData;
    box.put(listId, listData);

    syncToCloud(tableId: currentSelectedTable(), where: 'lists', action: 'ie', itemId: itemId, listId: listId, isEdit: true, editedItems: type, data: itemData);
  } catch (e) {
    errorPrint('edit-list-item-single-key', e);
    showToast(0, 'Could not edit list item');
  }
}
