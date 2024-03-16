import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:sessions/_widgets/components/toast.dart';

import '../../features/_tables/_helpers/notifications.dart';
import '../_common_helpers/global_helper.dart';

int getNotificationId(String id) {
  return id.length > 9 ? int.parse(id.substring(id.length - 9)) : int.parse(id);
}

Future<void> showNotification({required String type, required String title, required String body, required Map<String, String> data}) async {
  try {
    if (['z', 's', 'n', 't', 'b', 'i', 'c'].contains(type)) {
      if (isNotificationAllowed(type)) {
        if (kIsWeb) {
          showToast(2, '<b>$title</b><br>$body', duration: 5);
        } else {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 0,
              channelKey: 'basic_channel',
              title: title,
              body: body,
              payload: data,
              notificationLayout: NotificationLayout.BigText,
              wakeUpScreen: true,
            ),
            actionButtons: [
              NotificationActionButton(
                key: 'view_details',
                label: 'View Details',
              ),
            ],
          );
        }
      }
    }
  } catch (e) {
    errorPrint('show-notification', e);
  }
}

Future<void> createReminderNotification({
  required int id,
  required String title,
  required String body,
  required Map<String, String> data,
  required DateTime date,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'scheduled_channel',
      title: title,
      body: body,
      payload: data,
      notificationLayout: NotificationLayout.BigText,
      category: NotificationCategory.Reminder,
      wakeUpScreen: true,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'view_details',
        label: 'View Details',
      ),
    ],
    schedule: NotificationCalendar(
      year: date.year,
      month: date.month,
      day: date.day,
      hour: date.hour,
      minute: date.minute,
      second: date.second,
    ),
  );
}

Future<void> cancelScheduledNotification(String id) async {
  await AwesomeNotifications().cancel(getNotificationId(id));
}
