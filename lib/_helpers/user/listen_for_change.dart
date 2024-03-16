import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:sessions/_helpers/user/update_user_data.dart';

import '../../_services/cloud/firebase_database.dart';
import '../_common_helpers/global_helper.dart';
import 'get_user_data.dart';
import 'user_info.dart';

StreamSubscription<DatabaseEvent>? listenForUserDataChange() {
  try {
    String userId = getCurrentUserId();

    return FirebaseDatabase.instance.ref().child('$usersPathCloud/$userId/activity/latest').onValue.listen((event) async {
      String newVersion = event.snapshot.value != null ? event.snapshot.value as String : '';

      if (newVersion.isNotEmpty) {
        String localUserDataVersion = getLocalUserDataVersion();
        // print('$newVersion :: $localUserDataVersion');
        if (localUserDataVersion.isNotEmpty) {
          if (newVersion != localUserDataVersion) {
            printThis('New USER Data: $newVersion > $localUserDataVersion');

            await cloudService.getDataStartAfter('$usersPathCloud/$userId/activity', localUserDataVersion).then((snapshot) {
              Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
              // remove the latest-version-key, seing as it is not an activity
              newActivites.remove('latest');

              newActivites.forEach((activityId, activity) async {
                await updateUserData(userId, activity);
              });
            });
            await updateUseDataActivityVersion(newVersion);
          }
        } else {
          //
          //
          printThis('Missing USER Data... getting data from cloud');
          getAllUserDataFromCloud(userId);
        }
      }
    });
  } catch (e) {
    return null;
  }
}
