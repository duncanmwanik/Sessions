import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/activity/finalize_activity.dart';
import '../../../../_helpers/notifications/create_notification.dart';
import '../../../../_services/cloud/firebase_database.dart';
import '../../../../_variables/common_variables.dart';
import '../../../_tables/_helpers/get_table_data.dart';

Future<void> addToListItemData(String tableId, String action, List activityData) async {
  try {
    Box box = await Hive.openBox('${tableId}_lists');

    String listId = activityData[1];
    String itemId = activityData[2];
    String editedItems = activityData[3];
    Map listData = box.get(listId);
    String listTitle = listData['t'] ?? '-';
    Map listItemData = listData['i'] ?? {};
    Map itemData = listItemData[itemId] ?? {};

    //
    // create
    //
    if (action == 'ic') {
      await cloudService.getData('$tablesPathCloud/$tableId/lists/$listId/i/$itemId').then((snapshot) async {
        Map itemData = snapshot.value != null ? snapshot.value as Map : {};
        listItemData[itemId] = itemData;
        listData['i'] = listItemData;
        box.put(listId, listData);
      });
    }
    //
    // edit
    //
    if (action == 'ie') {
      getSplitList(editedItems).forEach((editedItem) async {
        //
        // delete item key
        //
        if (editedItem.startsWith('d')) {
          String key = editedItem.split('/')[1];
          itemData.remove(key);
          listItemData[itemId] = itemData;
          listData['i'] = listItemData;
          box.put(listId, listData);
        }
        //
        // add item key
        //
        else {
          await cloudService.getData('$tablesPathCloud/$tableId/lists/$listId/i/$itemId/$editedItem').then((snapshot) async {
            String keyData = snapshot.value != null ? snapshot.value as String : '';
            itemData[editedItem] = keyData;
            listItemData[itemId] = itemData;
            listData['i'] = listItemData;
            box.put(listId, listData);
          });
        }
        //
        //
        //
      });
    }
    //
    // delete entire list item
    //
    if (action == 'id') {
      listItemData.remove(itemId);
      listData['i'] = listItemData;
      box.put(listId, listData);
    }
    //
    //
    //
    String activityDescription = '<b>${activityData[4]}</b> ${activityTypes[action.substring(1, 2)] ?? 'updated'} an item in the list <b>$listTitle</b>.';

    await showNotification(
      type: 'i',
      title: getTableName(tableId),
      body: activityDescription,
      data: {'type': 'listItems', 'tableId': tableId, 'listId': listId, 'itemId': itemId},
    );

    saveActivity(tableId, activityDescription);
    //
    //
    //
  } catch (e) {
    errorPrint('update-list-item-data', e);
  }
}
