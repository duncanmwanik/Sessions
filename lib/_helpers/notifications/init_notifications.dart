import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'listen_for_notification.dart';

Future<void> initializeNotifications() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/trw',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Table Updates',
        defaultColor: Colors.lightBlueAccent,
        importance: NotificationImportance.High,
        channelDescription: 'Table Updates',
        channelShowBadge: true,
        playSound: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Table Sessions',
        defaultColor: Colors.lightBlueAccent,
        importance: NotificationImportance.High,
        channelDescription: 'Scheduled Table Sessions',
        channelShowBadge: true,
        playSound: true,
      ),
    ],
  );

  AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
}
