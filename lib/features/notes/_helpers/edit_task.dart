import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/edits/compare_data.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/toast.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../files/_helpers/upload_files.dart';
import '../../reminders/_helpers/register_reminder.dart';

Future<void> editTask(Map editedTaskData, Map previousTaskData) async {
  try {
    String tableId = currentSelectedTable();
    String taskId = taskInputProviderX.selectedTaskId;

    Map comparedData = compareData(type: 'tasks', previousData: previousTaskData, editedData: editedTaskData);
    String editedItems = comparedData['editedItems'];
    Map validatedData = comparedData['validatedData'];

    if (editedItems.isNotEmpty) {
      await Hive.box('${currentSelectedTable()}_tasks').put(taskId, validatedData);
      registerReminder(type: 'tasks', itemId: taskId, itemData: editedTaskData, reminderDate: editedTaskData['r']);
      handleFilesCloud(tableId, validatedData, items: editedItems);
      syncToCloud(tableId: tableId, where: 'tasks', action: 'te', itemId: taskId, isEdit: true, editedItems: editedItems, data: validatedData);
    }
  }
  //
  //
  catch (e) {
    showToast(0, 'Could not edit task');
  }
}
