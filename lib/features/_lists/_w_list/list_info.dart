import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../_config/styling/spacing.dart';
import '../../labels/label_list.dart';
import '../../reminders/reminder.dart';

class ListInfo extends StatelessWidget {
  const ListInfo({Key? key, required this.listId, required this.listData}) : super(key: key);

  final String listId;
  final Map listData;

  @override
  Widget build(BuildContext context) {
    String reminder = listData['r'] ?? '';
    String labels = listData['l'] ?? '';
    String bgColor = listData['c'] ?? 'x';

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // Reminder
          if (reminder.isNotEmpty) kIsWeb ? mediumSpacerHeight() : smallSpacerHeight(),
          if (reminder.isNotEmpty) Reminder(where: 'lists', itemId: listId, reminder: reminder, bgColor: bgColor),
          //
          //
          // Label list
          if (labels.isNotEmpty && reminder.isEmpty) smallSpacerHeight(),
          if (labels.isNotEmpty && reminder.isNotEmpty) smallSpacerHeight(),
          if (labels.isNotEmpty) LabelList(where: 'lists', itemId: listId, labelString: labels, bgColor: bgColor),
          //
          //
        ],
      ),
    );
  }
}
