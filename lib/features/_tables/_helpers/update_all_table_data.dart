import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/_common_helpers/loaders.dart';
import '../../../_services/cloud/firebase_database.dart';
import '../../../_services/hive/local_storage_service.dart';
import 'get_table_data.dart';
import 'update_table_data.dart';

Future<void> updateAllTableData(String tableId, {bool? isFirstTime}) async {
  showOnUpdateLoader(true);

  if (isFirstTime == true) {
    tableActivityVersionBox.put(tableId, '1');
  }

  await updateTableData(tableId, 'zu', ['', '']); // gets table info
  await getTableNameFromCloud(tableId);
  await updateTableAdminData(tableId);
  await updateTableActivityVersion(tableId);
  await updateTableAllSessions(tableId);
  await updateTableAllNotes(tableId);
  await updateTableAllTasks(tableId);
  await updateTableAllBoards(tableId);
  await updateTableAllLabels(tableId);
  await updateTableAllFlags(tableId);

  showOnUpdateLoader(false);

  printThis('::: Updated ALL TABLE data for "${getTableName(tableId)}"');
}

Future<void> updateTableAdminData(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/admins').then((snapshot) async {
      Map tableAdminData = snapshot.value != null ? snapshot.value as Map : {};
      if (tableAdminData.isNotEmpty) {
        await Hive.openBox('${tableId}_admins').then((box) async {
          await box.clear();
          box.putAll(tableAdminData);
        });
      }
    });
  } catch (e) {
    errorPrint('update-table-admin-data-from-firebase', e);
  }
}

Future<void> updateTableAllSessions(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/sessions').then((snapshot) async {
      Map tableSessions = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox(tableId).then((box) {
        tableSessions.forEach((date, sessions) {
          box.put(date, sessions);
        });
      });
    });
  } catch (e) {
    errorPrint('update-table-all-sessions-from-firebase', e);
  }
}

Future<void> updateTableAllNotes(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/notes').then((snapshot) async {
      Map tableNotes = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_notes').then((box) {
        tableNotes.forEach((noteId, noteData) {
          box.put(noteId, noteData);
        });
      });
    });
  } catch (e) {
    errorPrint('update-table-all-notes-from-firebase', e);
  }
}

Future<void> updateTableAllTasks(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/tasks').then((snapshot) async {
      Map tableTasks = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_tasks').then((box) {
        tableTasks.forEach((taskId, taskData) {
          box.put(taskId, taskData);
        });
      });
    });
  } catch (e) {
    errorPrint('update-table-all-tasks-from-firebase', e);
  }
}

Future<void> updateTableAllBoards(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/lists').then((snapshot) async {
      Map tableBoards = snapshot.value != null ? snapshot.value as Map : {};
      if (tableBoards.isNotEmpty) {
        await Hive.openBox('${tableId}_lists').then((box) {
          box.putAll(tableBoards);
        });
      }
    });
  } catch (e) {
    errorPrint('update-table-all-tasks-from-firebase', e);
  }
}

Future<void> updateTableAllLabels(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/labels').then((snapshot) async {
      Map labelsData = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_labels').then((box) {
        box.putAll(labelsData);
      });
    });
  } catch (e) {
    errorPrint('update-table-all-labels-from-firebase', e);
  }
}

Future<void> updateTableAllFlags(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/flags').then((snapshot) async {
      Map flagsData = snapshot.value != null ? snapshot.value as Map : {};
      await Hive.openBox('${tableId}_flags').then((box) {
        box.putAll(flagsData);
      });
    });
  } catch (e) {
    errorPrint('update-table-all-flags-from-firebase', e);
  }
}

Future<void> updateTableActivityVersion(String tableId) async {
  try {
    await cloudService.getData('$tablesPathCloud/$tableId/activity/latest').then((snapshot) {
      if (snapshot.value != null) {
        tableActivityVersionBox.put(tableId, snapshot.value as String);
      }
    });
  } catch (e) {
    errorPrint('update-table-activity-data-from-firebase', e);
  }
}
