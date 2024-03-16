import '../../features/_chat/_helpers/update_chat.dart';
import '../../features/_lists/_helpers/list/update_list.dart';
import '../../features/_lists/_helpers/list_item/update_list_item.dart';
import '../../features/_sessions/_helpers/update_session_data.dart';
import '../../features/_tables/_helpers/update_table_data.dart';
import '../../features/flags/_helpers/update_flag.dart';
import '../../features/labels/_helpers/update_labels.dart';
import '../../features/notes/_helpers/update_tasks.dart';

Future<bool> actOnActivity(String tableId, String activity, String timestamp) async {
  try {
    List<String> activityData = activity.split(',');
    String type = activity.substring(0, 1);
    String action = activityData[0];

    switch (type) {
      // ----------------------------- Tables
      case 'z':
        await updateTableData(tableId, action, activityData);
        break;

      // ----------------------------- Sessions
      case 's':
        await updateSessionData(tableId, action, activityData);
        break;

      // ----------------------------- Chat
      case 'c':
        await updateChat(tableId, activityData[1]);
        break;

      // ----------------------------- Notes
      // case 'n':
      //   await updateNoteData(tableId, action, activityData);
      //   break;

      // ----------------------------- Tasks
      case 't':
        await updateTaskData(tableId, action, activityData);
        break;

      // ----------------------------- Lists
      case 'b': // Lists
        await updateListData(tableId, action, activityData);
        break;
      //
      case 'i': // List Items
        await addToListItemData(tableId, action, activityData);
        break;

      // ----------------------------- Labels
      case 'l':
        await updateLabelData(tableId, action, activityData[1]);
        break;

      // ----------------------------- Flags
      case 'f':
        await updateFlagData(tableId, action, activityData);
        break;

      default:
    }
    return true;
  } catch (e) {
    return false;
  }
}
