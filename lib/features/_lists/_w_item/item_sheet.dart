import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/features/_lists/_w_item/item_flag_list.dart';
import 'package:sessions/features/_lists/_w_item/menu_delete_item.dart';
import 'package:sessions/features/reminders/reminder.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/bottom_sheet.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../../files/_helpers/upload_files.dart';
import '../../flags/dialog_manage_flags.dart';
import '../../reminders/dialog_set_reminder.dart';
import '../_helpers/list_item/edit_list_item.dart';
import '../_state/list_item_input_provider.dart';
import 'item_files.dart';
import 'item_text_input.dart';

Future<void> showItemBottomSheet(BuildContext context, String itemId, Map itemData, String listId) async {
  await showAppBottomSheet(
    //
    isMinimized: !showSheetAsDialog(),
    //
    // Content
    //
    content: Consumer<ListItemInputProvider>(builder: (context, inputProvider, child) {
      List alreadySelectedFlags = getSplitList(inputProvider.listItemData['g']);
      String reminder = inputProvider.listItemData['r'] ?? '';

      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: itemPadding(top: true),
          children: [
            //
            // Save or Cancel Changes
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // Close Button
                //
                AppButton(
                  onPressed: () => popWhatsOnTop(),
                  child: Row(
                    children: [AppText(size: medium, text: 'Close')],
                  ),
                ),
                //
                // Save Button: Show only if there is changes made
                //
                if (!DeepCollectionEquality().equals(inputProvider.listItemData, inputProvider.previousListItemData))
                  AppButton(
                      color: styler.accentColor(),
                      onPressed: () async {
                        popWhatsOnTop();
                        editListItem(inputProvider.listItemData, inputProvider.previousListItemData);
                      },
                      child: Row(
                        children: [
                          AppIcon(Icons.done_rounded, color: styler.white),
                          smallSpacerWidth(),
                          AppText(size: medium, text: 'Save', textColor: styler.white),
                        ],
                      )),
                //
                //
              ],
            ),
            //
            mediumSmallSpacerHeight(),
            //
            // Edit Item Text
            //
            ItemTextInput(),
            //
            smallSpacerHeight(),
            //
            // Action bar
            //
            if (isTableAdmin())
              Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
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
                    faded: true,
                  ),
                  //
                  // Add attachment
                  //
                  AppIconButton(
                    onPressed: () async {
                      await getFilesToUpload(where: 'listItems');
                    },
                    Icons.attach_file_rounded,
                    faded: true,
                  ),
                  //
                  smallSpacerWidth(),
                  //
                  // Add Flag Button
                  //
                  AppIconButton(
                    onPressed: () async {
                      await showFlagsDialog(alreadySelectedFlags).then((flagList) {
                        if (flagList != null) {
                          inputProvider.addToListItemData('g', getJoinedList(flagList));
                        }
                      });
                    },
                    Icons.flag_outlined,
                    faded: true,
                  ),
                  //
                  smallSpacerWidth(),
                  //
                  // Delete Button
                  //
                  DeleteItem(bgColor: '', listId: listId, itemId: itemId),
                  //
                  //
                  //
                ],
              ),
            //
            smallSpacerHeight(),
            //
            Divider(),
            //
            // Reminder
            //
            if (reminder.isNotEmpty) Align(alignment: Alignment.centerLeft, child: Reminder(where: 'lists', reminder: reminder)),
            if (reminder.isNotEmpty && alreadySelectedFlags.isNotEmpty) smallSpacerHeight(),
            //
            //
            // Selected Flags list
            //
            ItemFlagList(flagList: alreadySelectedFlags),
            //
            //
            //
            ListItemFiles(),
            //
            // Only show these spacers if keyboard is closed
            // Otherwise they push the Item TextField too far up
            //
            largeSpacerHeight(),
            // largePlaceHolderHeight(),
            //
            //
          ],
        ),
      );
    }),
  );
}
