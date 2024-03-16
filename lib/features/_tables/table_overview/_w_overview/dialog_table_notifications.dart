import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../_helpers/get_table_data.dart';
import 'notification_item.dart';

Future showTableNotificationsDialog(BuildContext context) {
  return showAppDialog(
    title: 'Notifications',
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${currentSelectedTable()}_notifications').listenable(),
        builder: (context, box, widget) {
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              //
              //
              NotificationItem(label: 'Table', value: box.get('table', defaultValue: false), type: 'table'),
              //
              Divider(height: 0, thickness: 0.3),
              //
              NotificationItem(label: 'Sessions', value: box.get('sessions', defaultValue: false), type: 'sessions'),
              //
              Divider(height: 0, thickness: 0.3),
              //
              NotificationItem(label: 'Chat', value: box.get('chat', defaultValue: false), type: 'chat'),
              //
              Divider(height: 0, thickness: 0.3),
              //
              NotificationItem(label: 'Boards', value: box.get('lists', defaultValue: false), type: 'lists'),
              //
              Divider(height: 0, thickness: 0.3),
              //
              NotificationItem(label: 'Notes', value: box.get('notes', defaultValue: false), type: 'notes'),
              //
              Divider(height: 0, thickness: 0.3),
              //
              NotificationItem(label: 'Tasks', value: box.get('tasks', defaultValue: false), type: 'tasks'),
              //
              Divider(height: 0, thickness: 0.3),
              //
              NotificationItem(label: 'Explore', value: box.get('explore', defaultValue: false), type: 'explore'),
              //
              mediumSmallSpacerHeight(),
              //
            ],
          );
        }),
  );
}
