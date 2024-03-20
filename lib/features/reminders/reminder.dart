import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/text_styles.dart';
import 'package:sessions/features/_lists/_helpers/list_item/edit_list_item.dart';

import '../../_config/styling/helpers.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/date_time/reminders.dart';
import '../../_helpers/edits/edit_item_extras.dart';
import '../../_providers/_provider_variables.dart';
import '../../_variables/common_variables.dart';
import '../../_widgets/components/icons.dart';
import 'dialog_set_reminder.dart';

class Reminder extends StatelessWidget {
  const Reminder({Key? key, required this.reminder, this.bgColor, this.onPressed, this.where, this.itemId, this.listId}) : super(key: key);

  final String reminder;
  final String? bgColor;
  final Function()? onPressed;
  final String? where;
  final String? itemId;
  final String? listId;

  @override
  Widget build(BuildContext context) {
    bool hasPassed = hasReminderAlreadyPassed(reminder);

    bool isListItemEdit = listId != null;
    bool isOtherEdit = itemId != null && where != null && listId == null;
    bool isEditInput = itemId == null && listId == null;

    return ElevatedButton(
      onPressed: onPressed ??
          () async {
            await showSetReminderDialog(reminder: reminder).then((reminder) async {
              //
              // Set the reminder
              //
              if (reminder != null && reminder != 'remove') {
                if (isListItemEdit) {
                  editListItemSingleKey(itemId!, listId!, 'r', reminder);
                }
                if (isOtherEdit) {
                  await editItemExtras(where: where!, action: typeActionsEdit[where], itemId: itemId!, type: 'r', value: reminder);
                }
                if (isEditInput) {
                  if (where == 'tasks') {
                    taskInputProviderX.addToTaskInputData('r', reminder);
                  } else if (where == 'lists') {
                    listInputProviderX.addToListInputData('r', reminder);
                  } else if (where == 'lists') {
                    listItemInputProviderX.addToListItemData('r', reminder);
                  }
                }
              }
              //
              // Remove the reminder
              //
              if (reminder == 'remove') {
                if (isListItemEdit) {
                  editListItemSingleKey(itemId!, listId!, 'd/r', '');
                }
                if (isOtherEdit) {
                  await editItemExtras(where: where!, action: typeActionsEdit[where], itemId: itemId!, type: 'd/r', value: '');
                }
                if (isEditInput) {
                  if (where == 'tasks') {
                    taskInputProviderX.removeFromTaskInputData('r');
                  } else if (where == 'lists') {
                    listInputProviderX.removeFromListInputData('r');
                  } else if (where == 'lists') {
                    listItemInputProviderX.removeFromListItemData('r');
                  }
                }
              }
              //
            });
          },
      style: ElevatedButton.styleFrom(
        side: BorderSide.none,
        backgroundColor: styler.reminderOverviewColor(bgColor),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: kIsWeb ? 15 : 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
        minimumSize: minSizeZero(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          // Reminder Icon
          //
          AppIcon(
            Icons.notifications_active,
            size: 14,
            color: hasPassed ? styler.textColorFaded(inverted: hasBGColor(bgColor)) : styler.textColor(inverted: hasBGColor(bgColor)),
          ),
          //
          tinySpacerWidth(),
          //
          // Reminder Text
          //
          Flexible(
              child: FittedBox(
            child: AppText(
              size: small,
              text: getFormattedSingleReminder(reminder),
              textColor: hasPassed ? styler.textColorFaded(inverted: hasBGColor(bgColor)) : styler.textColor(inverted: hasBGColor(bgColor)),
              isCrossed: hasPassed,
              overflow: TextOverflow.visible,
            ),
          )),
          //
          //
        ],
      ),
    );
  }
}
