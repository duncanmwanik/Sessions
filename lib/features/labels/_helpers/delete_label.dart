import 'package:hive/hive.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_providers/_provider_variables.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> deleteLabel(String label) async {
  try {
    await Hive.box('${currentSelectedTable()}_labels').delete(label);
    labelsProviderX.removeFromLabelList(label);
    if (labelsProviderX.selectedLabel == label) {
      labelsProviderX.updateSelectedLabel('All');
    }

    syncToCloud(tableId: currentSelectedTable(), where: 'labels', action: 'ld', itemId: label, isDelete: true, label: label, data: {});
  }
  //
  catch (e) {
    errorPrint('delete-label', e);
  }
}
