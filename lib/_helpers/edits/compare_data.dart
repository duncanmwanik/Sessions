import 'package:collection/collection.dart';

import '../../_services/hive/local_storage_service.dart';

Map compareData({required String type, required Map previousData, required Map editedData}) {
  List editedItems = [];

  //
  //
  // ----------
  //
  //
  if (type == 'sessions') {
    //
    // new keys
    //
    editedData.forEach((key, value) {
      if (previousData.containsKey(key)) {
        if (value.toString().isNotEmpty) {
          if (previousData[key] != value) {
            editedItems.add(key);
          }
        }
      } else {
        if (value.toString().trim().isNotEmpty) {
          editedItems.add(key);
        }
      }
    });
    //
    // deleted keys
    //
    previousData.forEach((key, value) {
      if (!editedData.containsKey(key)) {
        editedData.remove(key);
        editedItems.add('d/$key');
        if (key.toString().startsWith('f')) {
          fileNamesBox.put(key, value);
        }
      }
    });
  }
  //
  //
  // ----------
  //
  //
  if (type == 'notes') {
    //
    // new keys
    //
    editedData.forEach((key, value) {
      if (previousData.containsKey(key)) {
        if (previousData[key] != value) {
          editedItems.add(key);
        }
      } else {
        editedItems.add(key);
      }
    });

    //
    // deleted keys
    //
    previousData.forEach((key, value) async {
      if (!editedData.containsKey(key)) {
        editedData.remove(key);
        editedItems.add('d/$key');
        if (key.toString().startsWith('f')) {
          await fileNamesBox.put(key, value);
        }
      }
    });
  }
  //
  //
  // ----------
  //
  //
  if (type == 'tasks') {
    //
    // new keys
    //
    editedData.forEach((key, value) {
      if (key != 'i') {
        if (previousData.containsKey(key)) {
          if (previousData[key] != value) {
            editedItems.add(key);
          }
        } else {
          editedItems.add(key);
        }
      }
    });

    //
    // deleted keys
    //
    previousData.forEach((key, value) async {
      if (key != 'i') {
        if (!editedData.containsKey(key)) {
          editedItems.add('d/$key');
          // if (key.toString().startsWith('f')) {
          //   await fileNamesBox.put(key, value);
          // }
        }
      }
    });

    //
    // for Task entries
    //
    Map previousSubTasks = previousData['i'] ?? {};
    Map editedSubTasks = editedData['i'] ?? {};

    editedSubTasks.forEach((key, value) {
      if (previousSubTasks.containsKey(key)) {
        if (!DeepCollectionEquality().equals(previousSubTasks[key], value)) {
          editedItems.add('i/$key');
        }
      } else {
        editedItems.add('i/$key');
      }
    });

    previousSubTasks.forEach((key, value) {
      if (!editedSubTasks.containsKey(key)) {
        editedItems.add('k/$key');
      }
    });

    editedData['i'] = editedSubTasks;
  }
  //
  //
  // ----------
  //
  //
  if (type == 'lists') {
    //
    // new keys
    //
    editedData.forEach((key, value) {
      if (key != 'i') {
        if (previousData.containsKey(key)) {
          if (previousData[key] != value) {
            editedItems.add(key);
          }
        } else {
          editedItems.add(key);
        }
      }
    });

    //
    // deleted keys
    //
    previousData.forEach((key, value) {
      if (key != 'i') {
        if (!editedData.containsKey(key)) {
          editedData.remove(key);
          editedItems.add('d/$key');
        }
      }
    });
  }
  //
  //
  // ----------
  //
  //
  if (type == 'listItems') {
    //
    // new keys
    //
    editedData.forEach((key, value) {
      if (previousData.containsKey(key)) {
        if (previousData[key] != value) {
          editedItems.add(key);
        }
      } else {
        editedItems.add(key);
      }
    });

    //
    // deleted keys
    //
    previousData.forEach((key, value) {
      if (!editedData.containsKey(key)) {
        editedData.remove(key);
        editedItems.add('d/$key');
        if (key.toString().startsWith('f')) {
          fileNamesBox.put(key, value);
        }
      }
    });
  }

  return {'editedItems': editedItems.join('|'), 'validatedData': editedData};
}
