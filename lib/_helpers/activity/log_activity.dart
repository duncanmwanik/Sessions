import '../../_services/cloud/firebase_database.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import '../user/user_info.dart';

class ActivityLogger {
  String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
  String userName = getCurrentUserName();
  String tableId = currentSelectedTable();

  Future<void> registerActivity(Map activity) async {
    await cloudService.writeData('$tablesPathCloud/$tableId/activity', activity);
    await cloudService.writeData('$tablesPathCloud/$tableId/activity', {'latest': timeStamp});
  }

  Future<void> logActivity({
    required String where,
    required String action,
    required String itemId,
    String items = '',
    String dates = '',
    String label = '',
    String flag = '',
    String color = '',
    String listId = '',
    String subItemId = '',
  }) async {
    Map activity = {};

    switch (action.substring(0, 1)) {
      case 'z':
        if (action != 'zc') {
          activity = {timeStamp: '$action,$items,$userName'};
        }
        break;
      case 's':
        activity = {timeStamp: '$action,$itemId,$items,$dates,$userName'};
        break;
      case 'n':
        activity = {timeStamp: '$action,$itemId,$items,$userName'};
        break;
      case 't':
        activity = {timeStamp: '$action,$itemId,$items,$userName'};
        break;
      case 'b':
        activity = {timeStamp: '$action,$itemId,$items,$userName'};
        break;
      case 'i':
        activity = {timeStamp: '$action,$listId,$itemId,$items,$userName,'};
        break;
      case 'l':
        activity = {timeStamp: '$action,$label'};
        break;
      case 'f':
        activity = {timeStamp: '$action,$flag,$color,$items'};
        break;
      case 'c':
        activity = {timeStamp: '$action,$itemId'};
        break;
      default:
        break;
    }

    if (activity.isNotEmpty) {
      registerActivity(activity);
    }
  }
}
