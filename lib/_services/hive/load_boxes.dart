import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/user/user_info.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import 'local_storage_service.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  await loadAllHiveBoxes();
}

Future<void> loadAllHiveBoxes() async {
  globalBox = await Hive.openBox('global');
  settingBox = await Hive.openBox('settings');
  tableNamesBox = await Hive.openBox('tableName');
  userEmailsBox = await Hive.openBox('userEmails');
  userBox = await Hive.openBox(getCurrentUserId());
  userDataBox = await Hive.openBox('${getCurrentUserId()}_data');
  tableActivityVersionBox = await Hive.openBox('tableActivityVersion');
  tableChatVersionBox = await Hive.openBox('tableChatVersion');
  pendingTableBox = await Hive.openBox('pendingTable');
  fileBox = await Hive.openBox('filePaths');
  fileNamesBox = await Hive.openBox('fileNames');

  String tableId = currentSelectedTable();
  await Hive.openBox(tableId);
  await Hive.openBox('${tableId}_info');
  await Hive.openBox('${tableId}_admins');
  await Hive.openBox('${tableId}_activity');
  await Hive.openBox('${tableId}_history');
  await Hive.openBox('${tableId}_chats');
  await Hive.openBox('${tableId}_notes');
  await Hive.openBox('${tableId}_tasks');
  await Hive.openBox('${tableId}_lists');
  await Hive.openBox('${tableId}_notifications');
  await Hive.openBox('${tableId}_labels');
  await Hive.openBox('${tableId}_flags');

  await Hive.openBox('none');
  await Hive.openBox('none_info');
  await Hive.openBox('none_admins');
  await Hive.openBox('none_activity');
  await Hive.openBox('none_history');
  await Hive.openBox('none_chats');
  await Hive.openBox('none_notes');
  await Hive.openBox('none_tasks');
  await Hive.openBox('none_lists');
  await Hive.openBox('none_notifications');
  await Hive.openBox('none_labels');
  await Hive.openBox('none_flags');
}
