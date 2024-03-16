import 'package:sessions/_helpers/user/user_sync.dart';
import 'package:sessions/_widgets/dialogs/confirmation_dialog.dart';

import '../../_services/hive/local_storage_service.dart';
import '../../_widgets/components/snackbar.dart';
import '../../_widgets/components/toast.dart';
import '../../_widgets/dialogs/dialog_select_groups.dart';
import '../_common_helpers/global_helper.dart';
import '../forms/regex_checks.dart';
import 'user_info.dart';

Future<void> addTableToGroup(String tableId) async {
  try {
    await showSelectTableGroupsDialog().then((groupNames) {
      if (groupNames.runtimeType == List && groupNames.isNotEmpty) {
        showSnackBar('Adding table to ${groupNames.length == 1 ? 'group' : 'groups'}...');
        // LOCAL
        //
        //
        for (String groupName in groupNames) {
          Map groupTables = userDataBox.get(groupName, defaultValue: {});
          groupTables[tableId] = 0;
          userDataBox.put(groupName, groupTables);
        }
        // CLOUD
        //
        syncUserDataCloud(userId: getCurrentUserId(), itemId: tableId, action: 'ga', groupList: groupNames);
        //
      }
    });
  } catch (e) {
    errorPrint('add-table-to-group', e);
  }
}

Future<void> removeTableFromGroup(String tableId, String groupName) async {
  try {
    showSnackBar('Removing table from <b>$groupName</b>...');

    String userId = getCurrentUserId();
    Map groupTables = userDataBox.get(groupName);
    groupTables.remove(tableId);
    userDataBox.put(groupName, groupTables);
    // CLOUD
    //
    syncUserDataCloud(userId: userId, itemId: tableId, action: 'gd', groupName: groupName);
    //
  } catch (e) {
    errorPrint('remove-table-from-group', e);
  }
}

Future<void> addNewTableToUserTableData(String userId, String tableId, List groupList) async {
  try {
    // CLOUD
    //
    // add table first
    syncUserDataCloud(userId: userId, itemId: tableId, action: 'at');
    //
    //

    // add table to the selected groups
    if (groupList.isNotEmpty) {
      // LOCAL
      //
      for (String groupName in groupList) {
        // add table to local
        Map groupTables = userDataBox.get(groupName, defaultValue: {});
        groupTables[tableId] = 0;
        userDataBox.put(groupName, groupTables);
      }
      // CLOUD
      //
      syncUserDataCloud(userId: userId, itemId: tableId, action: 'ga', groupList: groupList);
      //
    }

    //
  } catch (e) {
    errorPrint('add-new-table-to-user-data', e);
  }
}

Future<void> removeTableFromUserTableData(String userId, String tableId) async {
  try {
    Map userTables = userDataBox.toMap();

    userTables.forEach((key, value) async {
      // if it's a table
      if (key.toString().startsWith('table')) {
        if (key.toString() == tableId) {
          userDataBox.delete(key);
          // CLOUD
          //
          syncUserDataCloud(userId: userId, itemId: tableId, action: 'd');
          //
        }
      }
      // if it's a group
      else {
        Map groupTables = value as Map;
        // making a new map unlinks the map used for the loop(forEach)
        // prevents a null error, trust me nakshow
        Map newGroupTables = getNewMapFrom(groupTables);
        groupTables.forEach((table, value) async {
          if (table.toString() == tableId) {
            newGroupTables.remove(tableId);
            // CLOUD
            //
            syncUserDataCloud(userId: userId, itemId: tableId, action: 'gd', groupName: key);
            //
          }
        });
        userDataBox.put(key, newGroupTables);
      }
    });

    // CLOUD
    //
    syncUserDataCloud(userId: userId, itemId: tableId, action: 'zd');
    //
  } catch (e) {
    errorPrint('remove-table-from-user-data', e);
  }
}

Future<void> createGroup(String groupName) async {
  try {
    if (groupName.isNotEmpty) {
      if (isValidGroupName(groupName)) {
        hideKeyboard();
        popWhatsOnTop();
        showSnackBar('Creating <b>$groupName</b>...');

        // {k:0} allows us to keep the group even if it has no table
        userDataBox.put(groupName, {'k': 0});

        // CLOUD
        //
        syncUserDataCloud(userId: getCurrentUserId(), action: 'ag', groupName: groupName);
        //
      } else {
        showToast(0, 'Enter a valid name');
      }
    } else {
      showToast(0, "Group name can't be empty");
    }
  } catch (e) {
    errorPrint('create-group', e);
  }
}

Future<void> deleteGroup(String groupName) async {
  try {
    await showConfirmationDialog(title: 'Delete group: $groupName?', yeslabel: 'Delete').then((deleteYeah) async {
      print(deleteYeah);
      if (deleteYeah == true) {
        showSnackBar('Deleting <b>$groupName</b>...');
        String userId = getCurrentUserId();
        userDataBox.delete(groupName);

        // CLOUD
        //
        syncUserDataCloud(userId: userId, action: 'd', itemId: groupName);
        //
      }
    });
  } catch (e) {
    errorPrint('delete-group', e);
  }
}
