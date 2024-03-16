import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_variables/common_variables.dart';
import 'package:sessions/_widgets/components/toast.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> addLabel(String label) async {
  try {
    //
    // if label dows not exist already or is a default label
    //
    if (Hive.box('${currentSelectedTable()}_labels').containsKey(label) || specialLabelsIcons.keys.contains(label)) {
      // Future helps us show the toast consistently : bug
      Future.delayed(Duration(seconds: 0), () => showToast(0, 'Label already exists!'));
    }
    //
    //
    //
    else {
      Hive.box('${currentSelectedTable()}_labels').put(label, '0');

      syncToCloud(tableId: currentSelectedTable(), where: 'labels', action: 'lc', isNew: true, label: label, data: {label: '0'});
    }
    //
    //
    //
  } catch (e) {
    errorPrint('add-label', e);
  }
}
