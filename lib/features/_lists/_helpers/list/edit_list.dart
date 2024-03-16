import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/edits/compare_data.dart';
import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/toast.dart';
import '../../../_tables/_helpers/get_table_data.dart';
import '../checks.dart';

Future<void> editList(String listId, Map editedListData) async {
  try {
    String tableId = currentSelectedTable();
    Map previousListData = listInputProviderX.previousListData;

    String message = validateListInput(editedListData['t']);

    if (message.isEmpty) {
      Map comparedData = compareData(type: 'lists', previousData: previousListData, editedData: editedListData);
      String editedItems = comparedData['editedItems'];
      Map validatedData = comparedData['validatedData'];

      if (editedItems.isNotEmpty) {
        Map listData = Hive.box('${currentSelectedTable()}_lists').get(listId, defaultValue: {});

        getSplitList(editedItems).forEach((editedItem) {
          listData[editedItem] = validatedData[editedItem];
        });

        await Hive.box('${currentSelectedTable()}_lists').put(listId, listData);

        syncToCloud(tableId: tableId, where: 'lists', action: 'be', itemId: listId, isEdit: true, editedItems: editedItems, data: validatedData);
      }
      // pop dialog
      popWhatsOnTop();
    }
    //
    else {
      showToast(0, message);
    }
    //
    //
    //
    //
  } catch (e) {
    showToast(0, 'Could not edit list');
  }
}
