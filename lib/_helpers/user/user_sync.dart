import 'package:sessions/_helpers/user/update_user_data.dart';

import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/_common_helpers/internet_connection.dart';
import '../../_helpers/pending/pending_actions.dart';
import '../../_services/cloud/firebase_database.dart';

Future<bool> syncUserDataCloud({
  required String userId,
  required String action,
  String itemId = '',
  String groupName = '',
  List groupList = const [],
}) async {
  try {
    //
    // check for internet access
    //
    hasAccessToInternet().then((hasInternet) async {
      if (hasInternet) {
        syncUserData(userId: userId, action: action, itemId: itemId, groupName: groupName, groupList: groupList);

        return true; // return success to any listening functions
      } else {
        await addToPendingActions(userId: userId, where: 'user', action: action, itemId: itemId, groupList: groupList, groupName: groupName, tableId: '');

        return false;
      }
    });
    //
    //
    //
    //
    return false;
    //
    //
  } catch (e) {
    //
    //
    //
    // If syncing to cloud fails, we add the sync action to pending actions for retries.
    // Retries involve calling this same 'syncToCloud' function with the same exact data.
    //
    await addToPendingActions(userId: userId, where: 'user', action: action, itemId: itemId, groupList: groupList, groupName: groupName, tableId: '');
    //
    //
    // Log an error. *might be removed later
    errorPrint('sync- -$action', e);
    //
    //
    return false; // return a fail to any listening functions
  }
}

Future<bool> syncUserData({
  required String userId,
  required String action,
  String itemId = '',
  String groupName = '',
  List groupList = const [],
}) async {
  try {
    // Sync begins
    //

    // Adding table
    //
    if (action == 'at') {
      await cloudService.writeData('$usersPathCloud/$userId/data', {itemId: 0});
      await updateUserDataActivity('$action,$itemId', userId: userId);
    }
    // Adding group
    //
    if (action == 'ag') {
      cloudService.writeData('$usersPathCloud/$userId/data/$groupName', {'k': 0});
      await updateUserDataActivity('$action,$groupName');
    }
    //
    // Adding table to groups
    //
    if (action == 'ga') {
      //
      // Avoid error about modifying a list in a concurrent loop
      List groupListCopy = groupList.toList();

      for (String group in groupListCopy) {
        await cloudService.writeData('$usersPathCloud/$userId/data/$group', {itemId: 0});
      }
      print('list: ${getJoinedList(groupList)}');

      await updateUserDataActivity('$action,${getJoinedList(groupList)},$itemId');
    }
    //
    // delete table
    //
    if (action == 'd') {
      await cloudService.deleteData('$usersPathCloud/$userId/data/$itemId');
      await updateUserDataActivity('$action,$itemId');
    }
    //
    // delete table from group
    //
    if (action == 'gd') {
      await cloudService.deleteData('$usersPathCloud/$userId/data/$groupName/$itemId');
      await updateUserDataActivity('$action,$groupName,$itemId');
    }

    //
    //
    //
    //
    return true; // return success to any listening functions
    //
    //
  } catch (e) {
    //
    //
    //
    // If syncing to cloud fails, we add the sync action to pending actions for retries.
    // Retries involve calling this same 'syncToCloud' function with the same exact data.
    //
    await addToPendingActions(userId: userId, where: 'user', action: action, itemId: itemId, groupList: groupList, groupName: groupName, tableId: '');
    //
    //
    // Log an error. *might be removed later
    errorPrint('sync- -$action', e);
    //
    //
    return false; // return a fail to any listening functions
  }
}
