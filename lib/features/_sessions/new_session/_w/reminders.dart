import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/_sessions/new_session/_w/_w/reminder_item.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../_state/session_input_provider.dart';

class NewSessionReminders extends StatelessWidget {
  const NewSessionReminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(builder: (context, inputProvider, child) {
      List remindersList = getSplitList((inputProvider.sessionInputData['r'] ?? ''));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //
              // Icon
              //
              AppIcon(Icons.notification_add, faded: true),
              smallSpacerWidth(),
              //
              // Add Button
              //
              AppButton(
                  onPressed: () async {
                    hideKeyboard();
                    remindersList.add('30.m');
                    inputProvider.addToSessionInputData('r', getJoinedList(remindersList));
                  },
                  child: Row(
                    children: [
                      AppIcon(Icons.add_rounded, size: 19),
                      tinySpacerWidth(),
                      AppText(size: medium, text: 'Add Reminder'),
                    ],
                  )),
            ],
          ),
          //
          //
          kIsWeb ? smallSpacerHeight() : tinySpacerHeight(),
          //
          // Reminder List
          //
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: remindersList.isNotEmpty
                ? Column(
                    children: List.generate(remindersList.length, (index) {
                    String reminder = remindersList[index];

                    return ReminderItem(reminder: reminder);
                  }))
                : Padding(padding: itemPaddingMedium(left: true, top: true), child: AppText(size: small, text: 'No reminders set', faded: true)),
          ),
          //
          //
        ],
      );
    });
  }
}
