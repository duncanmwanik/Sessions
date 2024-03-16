import 'package:hive_flutter/hive_flutter.dart';

import '../../_providers/_provider_variables.dart';
import '../../_services/hive/local_storage_service.dart';
import '../_common_helpers/global_helper.dart';

bool isActivityActedOn(String tableId, String timestamp) {
  try {
    return Hive.box('${tableId}_history').containsKey(timestamp);
  } catch (e) {
    errorPrint('is-activity-acted-on', e);
    return false;
  }
}

void registerActivityAsDone(String tableId, String timestamp) {
  Hive.box('${tableId}_history').put(timestamp, true);
}

Future<void> updateTableActivityVersionToMostRecent(String tableId, String newVersion) async {
  tableActivityVersionBox.put(tableId, newVersion);
}

void saveActivity(String tableId, String text) {
  try {
    Hive.box('${tableId}_activity').put(activityProviderX.currentTimestamp, text);
  } catch (e) {
    errorPrint('save-activity-to-history', e);
    Hive.box('${tableId}_activity').put(activityProviderX.currentTimestamp, 'Recent changes were made');
  }
}
