import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/toast.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../files/_helpers/upload_files.dart';
import '../../reminders/_helpers/register_reminder.dart';

Future<void> createNewTask(Map newTaskData) async {
  try {
    String taskId = DateTime.now().microsecondsSinceEpoch.toString();
    String tableId = currentSelectedTable();

    await Hive.box('${currentSelectedTable()}_tasks').put(taskId, newTaskData);

    registerReminder(type: 'tasks', itemId: taskId, itemData: newTaskData, reminderDate: newTaskData['r']);
    handleFilesCloud(tableId, newTaskData);
    syncToCloud(tableId: tableId, where: 'tasks', action: 'tc', itemId: taskId, isNew: true, data: {taskId: newTaskData});
  }
  //
  //
  catch (e) {
    showToast(0, 'Could not create task');
  }
}
