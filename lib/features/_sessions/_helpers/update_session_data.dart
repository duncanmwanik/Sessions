import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/activity/finalize_activity.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/notifications/create_notification.dart';
import '../../../_services/cloud/firebase_database.dart';
import '../../../_variables/common_variables.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../reminders/_helpers/register_reminder.dart';

Future<void> updateSessionData(String tableId, String action, List activityData) async {
  try {
    Box box = await Hive.openBox(tableId);

    String sessionId = activityData[1];
    String editedItems = activityData[2];
    List dates = getSplitList(activityData[3].toString());
    String sessionTitle = '';

    if (['sc', 'ss'].contains(action)) {
      await cloudService.getData('$tablesPathCloud/$tableId/sessions/${dates.first}/$sessionId').then((snapshot) async {
        Map sessionData = snapshot.value != null ? snapshot.value as Map : {};

        if (sessionData.isNotEmpty) {
          for (String date in dates) {
            Map daySessions = box.get(date, defaultValue: {});
            daySessions[sessionId] = sessionData;
            box.put(date, daySessions);
            registerReminder(type: 'sessions', itemId: sessionId, itemData: sessionData, reminderDate: date);
          }

          sessionTitle = sessionData['t'] ?? '';
        }
      });
    }
    //
    //
    if (action == 'se') {
      getSplitList(editedItems).forEach((editedItem) async {
        if (editedItem.startsWith('d')) {
          String deletedKey = editedItem.split('/')[1];

          for (String date in dates) {
            Map daySessions = box.get(date, defaultValue: {});
            Map sessionData = daySessions[sessionId] ?? {};
            sessionTitle = sessionData['t'] ?? '';
            sessionData.remove(deletedKey);
            daySessions[sessionId] = sessionData;
            box.put(date, daySessions);
            registerReminder(type: 'sessions', itemId: sessionId, itemData: sessionData, reminderDate: date);
          }
        } else {
          await cloudService.getData('$tablesPathCloud/$tableId/sessions/${dates.first}/$sessionId/$editedItem').then((snapshot) async {
            String keyData = snapshot.value != null ? snapshot.value as String : '';

            if (keyData.isNotEmpty) {
              for (String date in dates) {
                Map daySessions = box.get(date, defaultValue: {});
                Map sessionData = daySessions[sessionId] ?? {};
                sessionData[editedItem] = keyData;
                sessionTitle = sessionData['t'] ?? '';
                daySessions[sessionId] = sessionData;
                box.put(date, daySessions);
                if (editedItem == 's') {
                  registerReminder(type: 'sessions', itemId: sessionId, itemData: sessionData, reminderDate: date);
                }
              }
            }
          });
        }
      });
    }
    //
    // delete entire session
    //
    if (action == 'sd') {
      for (String date in dates) {
        Map daySessions = box.get(date, defaultValue: {});
        Map sessionData = daySessions[sessionId] ?? {};
        sessionTitle = sessionData['t'] ?? '---';
        daySessions.remove(sessionId);
        box.put(date, daySessions);
        cancelScheduledNotification(sessionId);
      }
    }
    //
    //
    //
    String body = '';
    if (['ss'].contains(action)) {
      List newDates = [];
      for (String date in dates) {
        newDates.add(getDateInfo(date));
      }
      body =
          '<b>${activityData[4]}</b> ${activityTypes[action.substring(1, 2)] ?? 'updated'} session <b>$sessionTitle</b> from <b>${getDateInfo(activityData[2])}</b> to the dates <b>${newDates.join('/')}</b>.';
    } else if (['sd'].contains(action)) {
      body = '<b>${activityData[4]}</b> deleted session <b>$sessionTitle</b> from the date <b>${getDateInfo(dates.first)}</b>.';
    } else {
      List newDates = [];
      for (String date in dates) {
        newDates.add(getDateInfo(date));
      }

      body = '<b>${activityData[4]}</b> ${activityTypes[action.substring(1, 2)] ?? 'updated'} session <b>$sessionTitle</b> for the dates <b>${newDates.join('/')}</b>.';
    }
    await showNotification(
      type: 's',
      title: getTableName(tableId),
      body: body,
      data: {'type': 's', 'tableId': tableId, 'sessionId': sessionId},
    );
    saveActivity(tableId, body);
  } catch (e) {
    errorPrint('update-session-data', e);
  }
}
