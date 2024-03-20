import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../../_helpers/date_time/reminders.dart';
import '../../../../../_widgets/components/icons.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../_state/session_input_provider.dart';

class ReminderItem extends StatefulWidget {
  const ReminderItem({super.key, required this.reminder});

  final String reminder;

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  @override
  Widget build(BuildContext context) {
    String reminderNo = widget.reminder.split('.')[0];
    String reminderPeriod = widget.reminder.split('.')[1];

    return Consumer<SessionInputProvider>(builder: (context, inputProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            // Change Reminder No
            //
            Flexible(
              child: Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                  color: styler.appColor(1),
                  borderRadius: BorderRadius.circular(borderRadiusMedium),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      String newReminder = '${value.trim()}.$reminderPeriod';
                      List remindersList = getSplitList((inputProvider.sessionInputData['r'] ?? ''));
                      remindersList.remove(widget.reminder);
                      remindersList.add(newReminder);
                      inputProvider.addToSessionInputData('r', getJoinedList(remindersList));
                    }
                  },
                  initialValue: reminderNo,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: textSizeNormal, color: styler.textColor()),
                  decoration: InputDecoration(
                    hintText: 'No.',
                    hintStyle: TextStyle(fontSize: textSizeNormal),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: formBorder,
                    counterStyle: TextStyle(height: double.minPositive),
                    counterText: '',
                  ),
                ),
              ),
            ),
            //
            //
            smallSpacerWidth(),
            //
            // Change Reminder period
            //
            Flexible(
              child: Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: styler.appColor(1),
                  borderRadius: BorderRadius.circular(borderRadiusMedium),
                ),
                child: DropdownButton(
                  value: reminderPeriodsMap[reminderPeriod],
                  icon: Padding(padding: const EdgeInsets.only(left: 5), child: const AppIcon(Icons.arrow_drop_down)),
                  underline: NoWidget(),
                  dropdownColor: styler.tertiaryColor(),
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                  items: reminderPeriodsMap.entries.map((entry) => DropdownMenuItem(value: entry.value, child: AppText(size: medium, text: entry.value))).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      String newReminder = '$reminderNo.${newValue.toString().substring(0, 1)}';
                      List remindersList = getSplitList((inputProvider.sessionInputData['r'] ?? ''));
                      remindersList.remove(widget.reminder);
                      remindersList.add(newReminder);
                      inputProvider.addToSessionInputData('r', getJoinedList(remindersList));
                    }
                  },
                ),
              ),
            ),
            //
            //
            // Remove Reminder
            //
            AppIconButton(
              onPressed: () {
                List remindersList = getSplitList((inputProvider.sessionInputData['r'] ?? ''));
                remindersList.remove(widget.reminder);
                if (remindersList.isEmpty) {
                  inputProvider.removeFromSessionInputData('r');
                } else {
                  inputProvider.addToSessionInputData('r', getJoinedList(remindersList));
                }
              },
              Icons.close,
              size: 14,
            ),
            //
            //
          ],
        ),
      );
    });
  }
}
