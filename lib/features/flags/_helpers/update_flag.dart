import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';

Future<void> updateFlagData(String tableId, String action, List activityData) async {
  try {
    Box box = await Hive.openBox('${tableId}_flags');

    String flag = activityData[1];
    String color = activityData[2];
    String previousFlag = activityData[3];

    if (action == 'fc') {
      await box.put(flag, color);
    }
    if (action == 'fe') {
      await box.delete(previousFlag);
      await box.put(flag, color);
    }
    if (action == 'fd') {
      await box.delete(flag);
    }
  } catch (e) {
    errorPrint('update-flag-data', e);
  }
}
