import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../task_sheet.dart';

Future<void> prepareTaskForEdit(String taskId, Map taskData) async {
  taskInputProviderX.updateSelectedTaskId(taskId);
  taskInputProviderX.updateAllInputData(taskData);
  reminderProviderX.updateBothDateAndTime(taskData['r']);
  showTaskBottomSheet(isNewTask: false);
}

Future<void> prepareTaskForCreation() async {
  taskInputProviderX.clearData();
  reminderProviderX.clearData();
  showTaskBottomSheet(isNewTask: true);
}

void addNewEntry() {
  String newEntryId = getUniqueIdMs();
  taskInputProviderX.updateNewEntryId(newEntryId);
  taskInputProviderX.addEntryToTaskInputData('', entryId: newEntryId);
  Future.delayed(Duration(seconds: 3), (() => taskInputProviderX.updateNewEntryId('')));
}

void addNewSubTitle() {
  String newEntryId = getUniqueIdMs();
  taskInputProviderX.updateNewEntryId(newEntryId);
  taskInputProviderX.addEntryToTaskInputData('', entryId: newEntryId);
  taskInputProviderX.updateEntryValue(newEntryId, 's');
  Future.delayed(Duration(seconds: 3), (() => taskInputProviderX.updateNewEntryId('')));
}

void addNewText() {
  String newEntryId = getUniqueIdMs();
  taskInputProviderX.updateNewEntryId(newEntryId);
  taskInputProviderX.addEntryToTaskInputData('', entryId: newEntryId);
  taskInputProviderX.updateEntryValue(newEntryId, 't');
  Future.delayed(Duration(seconds: 3), (() => taskInputProviderX.updateNewEntryId('')));
}

String getTaskEntriesAsText(Map entries) {
  try {
    List entriesText = [];

    entries.forEach((key, value) {
      if (value['t'] != null && value['t'].toString().trim().isNotEmpty) {
        entriesText.add('${value['t']}, ${value['v'] == '0' ? 'not done' : 'done'}');
      }
    });

    return entriesText.join('.\n');
  } catch (e) {
    errorPrint('task-entries-as-text', e);
    return '';
  }
}
