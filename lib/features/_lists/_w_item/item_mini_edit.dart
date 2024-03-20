import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/features/_lists/_state/list_item_input_provider.dart';
import 'package:sessions/features/_lists/_w_item/menu_delete_item.dart';

import '../../../../_widgets/components/icons.dart';
import '../../../_config/styling/helpers.dart';
import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../flags/dialog_manage_flags.dart';
import '../../reminders/dialog_set_reminder.dart';
import '../../reminders/reminder.dart';
import '../_helpers/list_item/edit_list_item.dart';
import 'item_flag_list.dart';

class ItemMiniEdits extends StatelessWidget {
  const ItemMiniEdits({Key? key, required this.bgColor}) : super(key: key);

  final String bgColor;

  @override
  Widget build(BuildContext context) {
    FocusNode editItemFocusNode = FocusNode();
    bool isColorInverted = hasBGColor(bgColor);

    return Consumer<ListItemInputProvider>(builder: (cxt, inputProvider, widget) {
      String reminder = inputProvider.listItemData['r'] ?? '';
      bool hasFlags = hasFlagList(inputProvider.listItemData['g']);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          // Text Input
          //
          TextFormField(
            onFieldSubmitted: (_) async {
              await editListItem(inputProvider.listItemData, inputProvider.previousListItemData);
              inputProvider.updateMiniEditsItemId('none');
            },
            onChanged: (value) => inputProvider.addToListItemData('t', value.trim()),
            initialValue: inputProvider.listItemData['t'],
            focusNode: editItemFocusNode,
            minLines: 2,
            maxLines: 6,
            textInputAction: TextInputAction.done,
            style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w400, color: styler.textColor(inverted: isColorInverted)),
            decoration: InputDecoration(
              hintText: 'Item',
              hintStyle: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: styler.textColorFaded(inverted: isColorInverted)),
              border: InputBorder.none,
              contentPadding: itemPadding(),
            ),
          ),
          //
          // Divider
          //
          Container(
            height: 1,
            width: double.maxFinite,
            decoration: BoxDecoration(color: styler.borderColor()),
          ),
          //
          //
          // Flag List
          //
          if (hasFlags) smallSpacerHeight(),
          if (hasFlags) ItemFlagList(flagList: getSplitList(inputProvider.listItemData['g']), isTinyFlag: true, isMiniEdit: true),
          //
          //
          // Reminder
          //
          if (reminder.isNotEmpty) smallSpacerHeight(),
          if (reminder.isNotEmpty) Align(alignment: Alignment.centerLeft, child: Reminder(where: 'lists', reminder: reminder, bgColor: bgColor)),
          if (reminder.isNotEmpty) tinySpacerHeight(),
          //
          if (reminder.isEmpty && !hasFlags) smallSpacerHeight(),
          //
          // Item Options
          //
          Wrap(
            children: [
              //
              // Add Reminder
              //
              AppIconButton(
                onPressed: () async {
                  showSetReminderDialog(reminder: reminder).then((reminder) async {
                    if (reminder != null && reminder != 'remove') {
                      inputProvider.addToListItemData('r', reminder);
                    }
                    if (reminder == 'remove') {
                      inputProvider.removeFromListItemData('r');
                    }
                  });
                },
                Icons.notification_add,
                tooltip: 'Add Reminder',
                size: 18,
                color: styler.textColorFaded(inverted: isColorInverted),
              ),
              //
              // Add Flags
              //
              AppIconButton(
                onPressed: () async {
                  List alreadySelectedFlags = getSplitList(inputProvider.listItemData['g']);

                  await showFlagsDialog(alreadySelectedFlags).then((flagList) {
                    if (flagList != null) {
                      inputProvider.addToListItemData('g', getJoinedList(flagList));
                    }
                  });
                },
                Icons.flag_outlined,
                tooltip: 'Flags',
                size: 18,
                color: styler.textColorFaded(inverted: isColorInverted),
              ),
              //
              // Delete Item
              //
              DeleteItem(bgColor: bgColor, listId: inputProvider.listId, itemId: inputProvider.itemId),
              //
            ],
          ),
          //
          //
          kIsWeb ? smallSpacerHeight() : tinySpacerHeight(),
          //
          // Save + Cancel Button
          //
          Wrap(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //
              // Cancel Button
              SaveButton(
                onPressed: () => inputProvider.updateMiniEditsItemId('none'),
                isCancel: true,
                label: 'Cancel',
              ),
              //
              smallSpacerWidth(),
              //
              // Save Button
              SaveButton(
                onPressed: () async {
                  await editListItem(inputProvider.listItemData, inputProvider.previousListItemData);
                  inputProvider.updateMiniEditsItemId('none');
                },
              ),
              //
              //
            ],
          ),
          //
          //
        ],
      );
    });
  }
}
