import 'package:collection/collection.dart';

import '../../../../_providers/_provider_variables.dart';
import 'create_task.dart';
import 'edit_task.dart';

void checkForChangeTasks(bool isNewTask) {
  bool thereIsChange = true;
  Map taskInputData = taskInputProviderX.taskInputData;
  Map previousTaskData = taskInputProviderX.previousTaskData;

  //
  if (DeepCollectionEquality().equals(previousTaskData, taskInputData)) {
    thereIsChange = false;
  }
  //
  else {
    if (isNewTask) {
      String title = taskInputData['t'] ?? '';
      Map entries = taskInputData['i'] ?? {};

      if (title.isEmpty && entries.isEmpty) {
        thereIsChange = false;
      }
    }
  }
  //
  //
  //
  if (thereIsChange) {
    if (isNewTask) {
      createNewTask(taskInputData);
    } else {
      editTask(taskInputData, previousTaskData);
    }
  }
  //
  //
  //
}
