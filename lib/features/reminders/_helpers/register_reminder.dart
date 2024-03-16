import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/date_time/reminders.dart';
import '../../../_helpers/notifications/create_notification.dart';

Future<void> registerReminder({
  required String type,
  required String itemId,
  required Map itemData,
  String? reminderDate,
  String? listName,
}) async {
  try {
    String title = '';
    String body = '';
    Map<String, String> data = {};
    //
    //
    //
    if (reminderDate != null && reminderDate.isNotEmpty) {
      //
      //
      //
      if (type == 'sessions') {
        String lead = itemData['l'] != null ? '<br>Led by: <b>${itemData['l']}</b>.' : '';
        String venue = itemData['v'] != null ? '<br>Venue: <b>${itemData['v']}</b>.' : '';
        String description = itemData['a'] != null ? '<br>${itemData['a']}.' : '';
        List remindersList = getSplitList(itemData['r']);

        if (remindersList.isNotEmpty) {
          for (String reminder in remindersList) {
            int reminderInMinutes = getReminderTimeInMinutes(reminder);
            DateTime date = DateTime.parse(getFormattedReminderDateTime(reminderDate, itemData['s'])).subtract(Duration(minutes: reminderInMinutes));

            if (date.isAfter(DateTime.now())) {
              int id = getNotificationId(itemId) + reminderInMinutes;
              title = itemData['t'] ?? 'Session';
              body = 'Starts in $reminderInMinutes minutes. $lead $venue $description';
              data = {'type': type};

              await createReminderNotification(id: id, title: title, body: body, data: data, date: date);
            }
          }
        }
      }
      //
      //
      //
      else {
        //
        //
        //
        DateTime date = DateTime.parse(reminderDate);

        if (date.isAfter(DateTime.now())) {
          //
          //
          //
          if (type == 'notes') {
            title = itemData['t'] ?? 'Note';
            body = itemData['m'] ?? '';
            data = {'type': type};
          }

          //
          //
          //
          if (type == 'tasks') {
            List taskEntries = [];
            Map subTasksData = itemData['i'] ?? {};
            (itemData['i'] ?? {}).forEach((subTaskId, data) {
              taskEntries.add('# ${subTasksData[subTaskId]['t']}');
            });

            title = itemData['t'] ?? 'Task';
            body = taskEntries.join('\n');
            data = {'type': type};
          }
          //
          //
          //
          if (type == 'lists') {
            title = itemData['t'] ?? 'List';
            body = 'You have items to achieve.';
            data = {'type': type};
          }
          //
          //
          //
          if (type == 'listItems') {
            if (listName != null) {
              title = listName;
              body = itemData['t'] ?? '';
              data = {'type': type};
            }
          }
          //
          //
          //
          if (title.isNotEmpty) {
            await createReminderNotification(id: getNotificationId(itemId), title: title, body: body, data: data, date: date);
          }
          //
          //
          //
        }
        //
        //
        //
      }
    }
    //
    //
    //
  } catch (e) {
    errorPrint('register-$type-notification', e);
  }
}
