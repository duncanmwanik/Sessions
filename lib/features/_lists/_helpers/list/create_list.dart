import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/toast.dart';
import '../../../_tables/_helpers/get_table_data.dart';
import '../checks.dart';

Future<void> createNewList(Map newListData) async {
  try {
    String listId = DateTime.now().microsecondsSinceEpoch.toString();
    String tableId = currentSelectedTable();
    String message = validateListInput(newListData['t']);

    if (message.isEmpty) {
      // close the dialog
      popWhatsOnTop();

      await Hive.box('${currentSelectedTable()}_lists').put(listId, newListData);

      syncToCloud(tableId: tableId, where: 'lists', action: 'bc', itemId: listId, isNew: true, data: {listId: newListData});
    }
    //
    else {
      showToast(0, message);
    }
    //
  }
  //
  //
  //
  catch (e) {
    showToast(0, 'Could not create list');
    errorPrint('create-list', e);
  }
}
