import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/features/reminders/_helpers/reminders.dart';

import '../../../../_widgets/components/text_styles.dart';

class SessionReminders extends StatelessWidget {
  const SessionReminders({super.key, required this.reminderString});

  final String reminderString;

  @override
  Widget build(BuildContext context) {
    List reminderList = getReminderList(reminderString);

    return Padding(
        padding: itemPaddingSmall(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            // Reminder Icon
            //
            AppIcon(Icons.notifications_outlined, tiny: true, faded: true),
            //
            smallSpacerWidth(),
            //
            // Reminder List
            //
            Flexible(
              child: Wrap(
                spacing: smallWidth(),
                runSpacing: tinyWidth(),
                children: List.generate(
                    reminderList.length,
                    (index) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(Icons.lens, size: 5, faded: true),
                            tinySpacerWidth(),
                            Flexible(child: AppText(size: medium, text: reminderList[index], fontWeight: FontWeight.w400, faded: true)),
                          ],
                        )),
              ),
            ),
          ],
        ));
  }
}
