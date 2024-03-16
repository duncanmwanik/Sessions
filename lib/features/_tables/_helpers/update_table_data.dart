import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/activity/finalize_activity.dart';
import '../../../_helpers/notifications/create_notification.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_services/cloud/firebase_database.dart';
import '../../../_services/hive/local_storage_service.dart';
import 'get_table_data.dart';

Future<void> updateTableData(String tableId, String action, List activityData) async {
  try {
    Box infoBox = await Hive.openBox('${tableId}_info');
    Box adminBox = await Hive.openBox('${tableId}_admins');

    String items = activityData[1];

    if (action == 'ze') {
      getSplitList(items).forEach((key) async {
        if (key.startsWith('d')) {
          infoBox.delete(key.split('/')[1]);
        } else {
          await cloudService.getData('$tablesPathCloud/$tableId/info/$key').then((snapshot) async {
            String keyData = snapshot.value != null ? snapshot.value as String : '';
            if (keyData.isNotEmpty) {
              infoBox.put(key, keyData);
              if (key == 't') {
                tableNamesBox.put(tableId, keyData);
              }
            }
          });
        }
      });
    }
    //
    //
    if (action == 'zu') {
      await cloudService.getData('$tablesPathCloud/$tableId/info').then((snapshot) async {
        Map tableInfo = snapshot.value != null ? snapshot.value as Map : {};
        if (tableInfo.isNotEmpty) {
          infoBox.putAll(tableInfo);
          tableNamesBox.put(tableId, tableInfo['t']);
        }
      });
    }
    //
    //
    if (action == 'za') {
      String userId = activityData[1];
      adminBox.put(userId, '0');
    }
    //
    //
    if (action == 'zr') {
      String userId = activityData[1];
      adminBox.delete(userId);
    }
    //
    //
    if (['ze'].contains(action)) {
      await showNotification(
        type: 'z',
        title: getTableName(tableId),
        body: '<b>${activityData[2]}</b> updated table details.',
        data: {'type': 'z', 'tableId': tableId},
      );
      saveActivity(tableId, '<b>${activityData[2]}</b> updated table details.');
    }
  } catch (e) {
    errorPrint('update-table-data', e);
  }
}

Future<void> updateSelectedTableId(String tableId, {String? newUserId}) async {
  await globalBox.put('${newUserId ?? getCurrentUserId()}_currentTableId', tableId);
}
