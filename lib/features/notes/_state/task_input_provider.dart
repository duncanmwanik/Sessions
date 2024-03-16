import 'package:flutter/material.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';

class TaskInputProvider with ChangeNotifier {
  // ---------- ---------- Tasks Data Input ---------- ----------
  // stores task data input when creating new or editing one

  Map taskInputData = {};
  Map previousTaskData = {};
  Map taskHolder = {};

  void updateAllInputData(Map taskData) {
    taskInputData = getNewMapFrom(taskData);
    previousTaskData = getNewMapFrom(taskData);
    taskHolder = taskInputData['i'] ?? {};
    notifyListeners();
  }

  void addToTaskInputData(String key, String value) {
    taskInputData[key] = value;
    notifyListeners();
  }

  void removeFromTaskInputData(String key) {
    taskInputData.remove(key);
    notifyListeners();
  }

  // Entries

  void addEntryToTaskInputData(String text, {String? entryId}) {
    if (!taskHolder.containsValue(text)) {
      taskHolder[entryId ?? getUniqueIdMs()] = {'t': text, 'v': '0'};
      taskInputData['i'] = taskHolder;
      notifyListeners();
    }
  }

  void removeEntryFromInputData(String key) {
    taskHolder.remove(key);
    taskInputData['i'] = taskHolder;
    notifyListeners();
  }

  void updateEntryName(String entryId, String newName) {
    if (taskHolder.containsKey(entryId)) {
      taskHolder[entryId]['t'] = newName;
      taskInputData['i'] = taskHolder;
      // notifyListeners();
    }
  }

  void updateEntryValue(String entryId, String newValue) {
    if (taskHolder.containsKey(entryId)) {
      taskHolder[entryId]['v'] = newValue;
      taskInputData['i'] = taskHolder;
      notifyListeners();
    }
  }

  //

  String selectedTaskId = '';

  void updateSelectedTaskId(String id) {
    selectedTaskId = id;
    notifyListeners();
  }

  //

  String newEntryId = '';

  void updateNewEntryId(String id) {
    newEntryId = id;
    notifyListeners();
  }

  //

  void clearData() {
    taskInputData.clear();
    taskHolder.clear();
    previousTaskData.clear();
    selectedTaskId = '';
    notifyListeners();
  }
}
