import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import 'dialog_table_notifications.dart';

class TableNotificationsTile extends StatelessWidget {
  const TableNotificationsTile({super.key, required this.tableName});

  final String tableName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onTap: () async {
          await showTableNotificationsDialog(context);
        },
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_active_rounded),
            SizedBox(width: smallWidth()),
            Flexible(
              child: Text(
                'Table Notifications',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right_rounded));
  }
}
