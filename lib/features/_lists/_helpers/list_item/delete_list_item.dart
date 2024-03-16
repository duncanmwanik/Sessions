import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_services/cloud/sync_to_cloud.dart';
import '../../../../_widgets/components/snackbar.dart';
import '../../../_tables/_helpers/get_table_data.dart';

Future<void> deleteListItem(listId, String itemId) async {
  try {
    //
    // This pops the menu
    popWhatsOnTop();
    // This pops the BottomSheet
    closeBottomSheetIfOpen();

    String tableId = currentSelectedTable();
    Box box = Hive.box('${currentSelectedTable()}_lists');
    Map listData = box.get(listId);
    Map listItemData = listData['i'] ?? {};
    listItemData.remove(itemId);
    listData['i'] = listItemData;
    box.put(listId, listData);

    showSnackBar('Deleted item...');

    syncToCloud(tableId: tableId, where: 'lists', action: 'id', itemId: itemId, listId: listId, isDelete: true, data: {});
  } catch (e) {
    errorPrint('delete-list-item', e);
    showSnackBar('Could not delete list item...');
  }
}
