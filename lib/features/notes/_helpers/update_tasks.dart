import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/activity/finalize_activity.dart';
import '../../../../_helpers/notifications/create_notification.dart';
import '../../../../_services/cloud/firebase_database.dart';
import '../../../../_variables/common_variables.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../reminders/_helpers/register_reminder.dart';

Future<void> updateTaskData(String tableId, String action, List activityData) async {
  try {
    Box box = await Hive.openBox('${tableId}_tasks');

    String taskId = activityData[1];
    String editedItems = activityData[2];
    String taskTitle = box.get(taskId, defaultValue: {})['t'] ?? '-';

    print('update: $editedItems');

    if (action == 'tc') {
      await cloudService.getData('$tablesPathCloud/$tableId/tasks/$taskId').then((snapshot) async {
        Map taskData = snapshot.value != null ? snapshot.value as Map : {};

        if (taskData.isNotEmpty) {
          await box.put(taskId, taskData);
          taskTitle = taskData['t'] ?? '-';
          registerReminder(type: 'tasks', itemId: taskId, itemData: taskData, reminderDate: taskData['r']);
        }
      });
    }
    //
    //
    //
    if (action == 'te') {
      Map taskData = box.get(taskId, defaultValue: {});
      Map allEntriesData = taskData['i'] ?? {};

      getSplitList(editedItems).forEach((editedItem) async {
        //
        // add or edit entry
        //
        if (editedItem.startsWith('i')) {
          String entryId = editedItem.split('/')[1];

          await cloudService.getData('$tablesPathCloud/$tableId/tasks/$taskId/i/$entryId').then((snapshot) async {
            Map entryData = snapshot.value != null ? snapshot.value as Map : {};

            if (entryData.isNotEmpty) {
              allEntriesData[entryId] = entryData;
            }
            taskData['i'] = allEntriesData;
          });
        }
        //
        // delete entry
        //
        else if (editedItem.startsWith('k')) {
          String entryId = editedItem.split('/')[1];

          allEntriesData.remove(entryId);
          taskData['i'] = allEntriesData;
        }
        //
        // delete task key
        //
        else if (editedItem.startsWith('d')) {
          String key = editedItem.split('/')[1];

          taskData.remove(key);
        }
        //
        // add or edit task key
        //
        else {
          await cloudService.getData('$tablesPathCloud/$tableId/tasks/$taskId/$editedItem').then((snapshot) async {
            String keyData = snapshot.value != null ? snapshot.value as String : '';

            if (keyData.isNotEmpty) {
              taskData[editedItem] = keyData;
            }
          });
        }
        //
        //
        //
      });

      await box.put(taskId, taskData);

      registerReminder(type: 'tasks', itemId: taskId, itemData: taskData, reminderDate: taskData['r']);
    }
    //
    //delete entire task
    //
    if (action == 'td') {
      await box.delete(taskId);
    }
    //
    // show notification and save activity
    //
    if (!['p', 'x', 'a'].contains(editedItems)) {
      String activityDescription = '<b>${activityData[3]}</b> ${activityTypes[action.substring(1, 2)] ?? 'updated'} task <b>$taskTitle</b>.';

      await showNotification(
        type: 't',
        title: getTableName(tableId),
        body: activityDescription,
        data: {'type': 't', 'tableId': tableId, 'taskId': taskId},
      );
      saveActivity(tableId, activityDescription);
    }
    //
    //
    //
  } catch (e) {
    errorPrint('update-task-data', e);
  }
}
