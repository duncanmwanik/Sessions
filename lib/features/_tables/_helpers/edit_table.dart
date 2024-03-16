import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_providers/_provider_variables.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/toast.dart';
import 'checks_table.dart';
import 'get_table_data.dart';

Map compareTableData(Map previousTable, Map editedTableData) {
  List items = [];

  //
  // Checking for added or edited keys
  //
  editedTableData.forEach((key, value) {
    // if key exists
    if (previousTable.containsKey(key)) {
      // if key is edited
      if (previousTable[key] != value) {
        items.add(key);
      }
    }
    // an added key
    else {
      items.add(key);
    }
  });

  //
  // Checking for deleted keys
  //
  previousTable.forEach((key, value) {
    // if key has been deleted
    if (!editedTableData.containsKey(key)) {
      editedTableData.remove(key);
      items.add('d/$key');
    }
  });

  return {'items': items.join('|'), 'validatedTableData': editedTableData};
}

Future<void> editTable(Map editedTableData) async {
  try {
    String validationResponse = validateTableInput(editedTableData['t']);

    if (validationResponse.isEmpty) {
      // close the create table bottom sheet
      popWhatsOnTop();

      String tableId = currentSelectedTable();
      Map previousTable = tableInputProviderX.previousTableData;
      Map validatedData = compareTableData(previousTable, editedTableData);
      String items = validatedData['items'];
      Map validatedTableData = validatedData['validatedTableData'];

      // if there are edits (items contains the keys that have been edited)
      if (items.isNotEmpty) {
        // LOCAL
        //
        // Update local table data
        await Hive.openBox('${tableId}_info').then((box) async {
          await box.putAll(validatedTableData);
        });
        // update table name in the table name tracker box
        await tableNamesBox.put(tableId, validatedTableData['t']);

        // CLOUD
        //
        //
        await syncToCloud(tableId: tableId, where: 'info', action: 'ze', isEdit: true, editedItems: items, data: validatedTableData);
        //
        //
        // clear table input provider maps as we dont need that data anymore
        // tableInputProviderX.clearTableInputData();
      }
    } else {
      // alert user of any unfilled necessary data
      showToast(0, validationResponse);
    }
  } catch (e) {
    errorPrint('edit-table', e);
  }
}
