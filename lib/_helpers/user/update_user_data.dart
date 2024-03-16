import '../../_services/cloud/firebase_database.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../features/_tables/_helpers/table_names.dart';
import '../_common_helpers/global_helper.dart';
import '../_common_helpers/internet_connection.dart';
import '../_common_helpers/loaders.dart';
import 'user_info.dart';

Future<void> updateUserData(String userId, String activity) async {
  try {
    showOnUpdateLoader(true);

    List activityList = getSplitList(activity, separator: ',');

    String action = activityList[0];
    String itemId = activityList[1]; // listId or groupId
    String subItemId = activityList.last; // listId, if itemId is groupId

    if (action == 'at') {
      userDataBox.put(itemId, 0);
    }
    if (action == 'ag') {
      userDataBox.put(itemId, {'k': 0});
    }
    if (action == 'ga') {
      List groupNames = getSplitList(itemId);
      for (String groupName in groupNames) {
        Map groupTables = userDataBox.get(groupName, defaultValue: {});
        groupTables[subItemId] = 0;
        userDataBox.put(groupName, groupTables);
      }
    }
    if (action == 'gd') {
      Map groupTables = userDataBox.get(itemId, defaultValue: {});
      groupTables.remove(subItemId);
      userDataBox.put(itemId, groupTables);
    }
    if (action == 'd') {
      userDataBox.delete(itemId);
    }
  } catch (e) {
    errorPrint('update-user-data', e);
  } finally {
    showOnUpdateLoader(false);
  }
}

Future<void> getAllUserDataFromCloud(String userId) async {
  try {
    hasAccessToInternet().then((hasIntenet) async {
      if (hasIntenet) {
        await cloudService.getData('$usersPathCloud/$userId/data').then((snapshot) async {
          Map userData = snapshot.value != null ? snapshot.value as Map : {};
          if (userData.isNotEmpty) {
            await userDataBox.clear();
            await userDataBox.putAll(userData);
            await saveTablesNamesToLocalStorage(userData);
          }
        });
        await cloudService.getData('$usersPathCloud/$userId/activity/latest').then((snapshot) async {
          String latestActivityVersion = snapshot.value != null ? snapshot.value as String : '';
          if (latestActivityVersion.isNotEmpty) {
            await updateUseDataActivityVersion(latestActivityVersion);
          }
        });
        print('Updated ALL USER data from cloud...');
      }
    });
  } catch (e) {
    errorPrint('get-all-user-data', e);
  }
}

Future<void> updateUserDataActivity(String activity, {String? userId}) async {
  String activityId = getUniqueId();
  await cloudService.writeData('$usersPathCloud/${userId ?? getCurrentUserId()}/activity', {activityId: activity, 'latest': activityId});
  userBox.put('version', activityId);
}

Future<void> updateUseDataActivityVersion(String newActivityVersion) async {
  userBox.put('version', newActivityVersion);
}
