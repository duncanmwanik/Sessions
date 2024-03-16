import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/toast.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/date_time/date_info.dart';
import '../../_helpers/date_time/datetime_helper.dart';
import '../../_widgets/components/text_styles.dart';
import '../../_widgets/dialogs/action_buttons.dart';
import '../../_widgets/dialogs/app_dialog.dart';
import '../../_widgets/dialogs/dialog_select_date.dart';
import '_state/reminders_provider.dart';

Future showSetReminderDialog({String reminder = ''}) {
  reminderProviderX.updateBothDateAndTime(reminder);

  bool hasReminder = reminder.isNotEmpty;

  return showAppDialog(
    title: 'Set a reminder',
    content: Consumer<ReminderProvider>(
      builder: (context, inputProvider, child) => Row(
        children: [
          //
          // Choose Date
          //
          InkWell(
            onTap: () async {
              await showSelectSingleDateDialog(initialDate: inputProvider.date).then((value) {
                if (value != null) {
                  inputProvider.updateDate(getDatePartFromDateTime(value));
                }
              });
            },
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: styler.itemColor(isDialog: true),
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
              child: Center(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.calendarPlus, size: textSizeNormal),
                  mediumSpacerWidth(),
                  Flexible(
                    child: AppText(
                      size: medium,
                      text: inputProvider.date.isNotEmpty ? getDayInfoFullNames(inputProvider.date) : 'Choose Date',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )),
            ),
          ),
          //
          smallSpacerWidth(),
          //
          //
          // Choose Time
          //
          InkWell(
            onTap: () async {
              await showTimePicker(
                context: context,
                initialTime: hasReminder ? TimeOfDay.fromDateTime(DateTime.parse(reminder)) : TimeOfDay.now(),
                cancelText: 'Cancel',
                confirmText: 'Done',
              ).then((value) {
                if (value != null) {
                  inputProvider.updateTime(getTimePartFromTimeOfDay(value));
                }
              });
            },
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: styler.itemColor(isDialog: true),
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
              child: Center(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.solidClock, size: textSizeNormal),
                  mediumSpacerWidth(),
                  Flexible(
                    child: AppText(
                      size: medium,
                      text: inputProvider.time.isNotEmpty ? get12HourTimeFrom24HourTime(inputProvider.time, islonger: true) : 'Choose Time',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    ),
    actions: [
      DialogActionButtonCancel(label: 'Close'),
      //
      //
      if (hasReminder)
        DialogActionButtonCancel(
            label: 'Remove',
            onPressed: (() {
              popWhatsOnTop(value: 'remove');
            })),
      //
      //
      DialogActionButtonAccept(
        label: hasReminder ? 'Save' : 'Set',
        onPressed: () {
          if (reminderProviderX.date.isNotEmpty && reminderProviderX.time.isNotEmpty) {
            popWhatsOnTop(value: '${reminderProviderX.date} ${reminderProviderX.time}');
          } else {
            // popWhatsOnTop();
            showToast(0, 'Choose a date and a time');
          }
        },
      ),
    ],
  );
}
