import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/activity/finalize_activity.dart';
import '../../../../_helpers/notifications/create_notification.dart';
import '../../../../_services/cloud/firebase_database.dart';
import '../../../../_variables/common_variables.dart';
import '../../../_tables/_helpers/get_table_data.dart';

Future<void> updateListData(String tableId, String action, List activityData) async {
  try {
    Box box = await Hive.openBox('${tableId}_lists');

    String listId = activityData[1];
    String editedItems = activityData[2];
    String listTitle = box.get(listId, defaultValue: {})['t'] ?? '-';

    if (action == 'bc') {
      await cloudService.getData('$tablesPathCloud/$tableId/lists/$listId').then((snapshot) async {
        Map listData = snapshot.value != null ? snapshot.value as Map : {};
        if (listData.isNotEmpty) {
          box.put(listId, listData);
          listTitle = listData['t'] ?? '-';
        }
      });
    }
    //
    // edit
    //
    if (action == 'be') {
      Map listData = box.get(listId, defaultValue: {});

      getSplitList(editedItems).forEach((editedItem) async {
        //
        // delete list key
        //
        if (editedItem.startsWith('d')) {
          String key = editedItem.split('/')[1];

          listData.remove(key);
        }
        //
        // add or edit list key
        //
        else {
          await cloudService.getData('$tablesPathCloud/$tableId/lists/$listId/$editedItem').then((snapshot) async {
            String keyData = snapshot.value != null ? snapshot.value as String : '';

            if (keyData.isNotEmpty) {
              listData[editedItem] = keyData;
            }
          });
        }

        box.put(listId, listData);
        //
        //
        //
      });
    }
    //
    // delete entire list
    //
    if (action == 'bd') {
      await box.delete(listId);
    }
    //
    //
    //
    if (!['p', 'x', 'a'].contains(editedItems)) {
      String activityDescription = '<b>${activityData[3]}</b> ${activityTypes[action.substring(1, 2)] ?? 'updated'} list <b>$listTitle</b>.';

      await showNotification(
        type: 'b',
        title: getTableName(tableId),
        body: activityDescription,
        data: {'type': 'lists', 'tableId': tableId, 'itemId': listId},
      );
      saveActivity(tableId, activityDescription);
    }
    //
    //
    //
  } catch (e) {
    errorPrint('update-list-data', e);
  }
}
