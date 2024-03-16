import '../../_providers/_provider_variables.dart';
import '../../_services/cloud/firebase_database.dart';
import '../_common_helpers/loaders.dart';
import 'act_on_activity.dart';
import 'finalize_activity.dart';

Future<void> getNewActivities(String tableId, String oldVersion, String newVersion) async {
  try {
    showOnUpdateLoader(true);

    await cloudService.getDataStartAfter('$tablesPathCloud/$tableId/activity', oldVersion).then((snapshot) {
      Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
      // remove the latest-version-key, seing as it is not an activity
      newActivites.remove('latest');
      newActivites.forEach((timestamp, activity) {
        if (!isActivityActedOn(tableId, timestamp)) {
          activityProviderX.updateCurrentActivity(timestamp, activity);

          actOnActivity(tableId, activity, timestamp).then((success) async {
            if (success && !activity.toString().startsWith('c')) {
              registerActivityAsDone(tableId, timestamp);
              print('......... Acted on new activity :: $activity');
            } else if (!success) {
              // await addToPendingActions(tableId: tableId, where: 'activity-action', itemId: timestamp, data: activity, action: 'a', isNew: false);
            }
          });
        }
      });
    });

    updateTableActivityVersionToMostRecent(tableId, newVersion);
  } catch (e) {
    // await addToPendingActions(tableId: tableId, where: 'update-data', itemId: newVersion, data: {'oldVersion': oldVersion}, action: 'a', isNew: false);
    // errorPrint('act-on-activity', e);
  } finally {
    showOnUpdateLoader(false);
  }
}
