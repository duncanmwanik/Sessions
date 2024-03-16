import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/features/_tables/_helpers/select_table.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/user/user_actions.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_providers/_provider_variables.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/toast.dart';
import 'checks_table.dart';

Future<void> createNewTable(Map newTableData, {String? newUserId}) async {
  try {
    String validationResponse = validateTableInput(newTableData['t']);

    if (validationResponse.isEmpty) {
      // close the create table bottom sheet
      if (newUserId == null) popWhatsOnTop();
      //
      // newUserId is used when creating a table for new user on sign up
      //
      String userId = newUserId ?? getCurrentUserId();
      String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      String tableId = 'table_${userId.substring(0, 6)}_${timeStamp.substring(9)}';
      List groupList = tableInputProviderX.selectedTableGroups;

      // set table owner
      newTableData['o'] = userId;
      // remove empty keys
      newTableData.removeWhere((key, value) => value.toString().isEmpty);

      // LOCAL
      //
      //
      // add table to user table data
      userDataBox.put(tableId, 0);
      // save table info data locally
      await Hive.openBox('${tableId}_info').then((box) async {
        await box.putAll(newTableData);
      });
      // add table creator to table admins list as a super-admin
      // super-admin have a value of '1'
      // other admins have a value of '0'
      await Hive.openBox('${tableId}_admins').then((box) async {
        await box.put(userId, 1);
      });
      // add table name to table names tracking box
      await tableNamesBox.put(tableId, newTableData['t']);
      // add user's email to email tracking box
      await userEmailsBox.put(userId, getCurrentUserEmail());
      // selects the newly created table app-wide
      await selectNewTable(tableId, newUserId: newUserId);

      // CLOUD
      //
      //
      // add table to cloud user data
      await addNewTableToUserTableData(userId, tableId, groupList);
      // create table in the cloud
      await syncToCloud(tableId: tableId, where: '', action: 'zc', itemId: tableId, isNew: true, editedItems: userId, data: {'info': newTableData});
      //
      //
      // clear table input provider maps as we dont need that data anymore
      // tableInputProviderX.clearTableInputData();
      //
    } else {
      // alert user of any unfilled necessary data
      showToast(0, validationResponse);
    }
  } catch (e) {
    errorPrint('create-table', e);
  }
}
