import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/components/tooltip.dart';
import 'package:sessions/features/_lists/_w_item/item_flag_list.dart';
import 'package:sessions/features/_lists/_w_item/item_mini_edit.dart';

import '../../../_config/styling/helpers.dart';
import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_providers/_provider_variables.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../files/files_overview.dart';
import '../../reminders/reminder.dart';
import '../_state/list_item_input_provider.dart';
import 'item_sheet.dart';

class Item extends StatelessWidget {
  const Item({Key? key, required this.itemId, required this.itemData, required this.listId, required this.bgColor}) : super(key: key);

  final String itemId;
  final Map itemData;
  final String listId;
  final String bgColor;

  @override
  Widget build(BuildContext context) {
    String reminder = itemData['r'] ?? '';
    bool isColorInverted = hasBGColor(bgColor);

    return Consumer<ListItemInputProvider>(builder: (cxt, inputProvider, widget) {
      bool showMiniEdits = (inputProvider.miniEditsItemId == itemId);

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
        child: InkWell(
          onTap: showMiniEdits
              ? null
              : () async {
                  inputProvider.updateAllInputData(itemId, listId, itemData);
                  inputProvider.updateMiniEditsItemId('none');
                  showItemBottomSheet(context, itemId, itemData, listId);
                },
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          child: Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: styler.listItemColor(inverted: isColorInverted),
              boxShadow: styler.listItemShadow(inverted: isColorInverted),
              borderRadius: BorderRadius.circular(showMiniEdits ? borderRadiusMedium : borderRadiusSmall),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // Flag List + Item Text + Mini Edits Button
                  //
                  if (!showMiniEdits)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        // Flag List + Item Text
                        //
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              // Flag List
                              //
                              ItemFlagList(flagList: getSplitList(itemData['g']), isTinyFlag: true),
                              //
                              //
                              if (hasFlagList(itemData['g'])) smallSpacerHeight(),
                              //
                              //
                              //
                              FilesOverview(fileData: itemData),
                              //
                              // Item Text
                              //
                              AppText(
                                size: medium,
                                text: itemData['t'] ?? '---',
                                fontWeight: FontWeight.w400,
                                textColor: styler.textColor(inverted: isColorInverted),
                                overflow: TextOverflow.visible,
                              ),
                              //
                              //
                              // Reminder
                              if (reminder.isNotEmpty) kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
                              if (reminder.isNotEmpty) Reminder(where: 'lists', itemId: itemId, listId: listId, reminder: reminder, bgColor: bgColor),
                            ],
                          ),
                        ),
                        //
                        smallSpacerWidth(),
                        //
                        // Mini Edits Button
                        //
                        AppTooltip(
                          message: 'Quick Edit',
                          child: ElevatedButton(
                            onPressed: () {
                              listItemInputProviderX.updateAllInputData(itemId, listId, itemData);
                              listItemInputProviderX.updateMiniEditsItemId(itemId);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.zero,
                              backgroundColor: styler.transparent,
                              minimumSize: minSizeZero(),
                              fixedSize: Size(20, 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: AppIcon(Icons.edit, size: 10, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  //
                  //
                  // Mini Edits
                  //
                  if (showMiniEdits) Flexible(child: ItemMiniEdits(bgColor: bgColor)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
