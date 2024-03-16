import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';

Future<void> updateLabelData(String tableId, String action, String label) async {
  try {
    Box box = await Hive.openBox('${tableId}_labels');

    if (action == 'lc') {
      await box.put(label, '0');
    }

    if (action == 'ld') {
      await box.delete(label);
    }
  } catch (e) {
    errorPrint('update-label-data', e);
  }
}
