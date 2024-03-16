import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_providers/common_providers/item_selection_provider.dart';
import 'package:sessions/_widgets/dialogs/confirmation_dialog.dart';
import 'package:sessions/_widgets/item_actions/hover_actions_more.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../_helpers/_common_helpers/delete_item_forever.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/edits/edit_item_extras.dart';
import '../../_variables/common_variables.dart';
import '../../features/labels/bottom_sheet_labels.dart';
import '../../features/reminders/dialog_set_reminder.dart';
import '../components/checkbox.dart';
import '../components/icons.dart';
import '../dialogs/dialog_item_bg_color.dart';

class HoverActions extends StatelessWidget {
  const HoverActions({
    Key? key,
    required this.showHoverOptions,
    required this.isPinned,
    required this.isArchived,
    required this.isDeleted,
    this.showPinned = false,
    this.showMore = false,
    required this.itemId,
    required this.itemData,
    required this.bgColor,
    required this.type,
    this.height = 50,
  }) : super(key: key);

  final bool showHoverOptions;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final bool showPinned;
  final bool showMore;
  final String itemId;
  final Map itemData;
  final String bgColor;
  final String type;
  final double height;

  @override
  Widget build(BuildContext context) {
    String reminder = itemData['r'] ?? '';
    String labels = itemData['l'] ?? '';
    String color = itemData['c'] ?? '';

    return Visibility(
      visible: isNotPhone(),
      child: Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
        bool inSelection = selectionProvider.selectedItemMap.isNotEmpty;
        bool isSelected = selectionProvider.selectedItemMap.containsKey(itemId);

        return SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              //
              //
              //
              // Checkbox for item selection
              //
              //
              (showHoverOptions || inSelection)
                  ? CheckBoxOverview(
                      isChecked: isSelected,
                      bgColor: bgColor,
                      isTiny: true,
                      faded: true,
                      onTap: () {
                        if (isSelected) {
                          selectionProvider.removeFromSelectedItemMap(itemId);
                        } else {
                          selectionProvider.addToSelectedItemMap(itemId, itemData['t'] ?? '', isPinned, type);
                        }
                      },
                    )
                  : NoWidget(),
              //
              //
              //
              //
              // Actions
              //
              //
              Flexible(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    //
                    // Labels
                    //
                    if (showHoverOptions && !inSelection && !isDeleted)
                      AppIconButton(
                        onPressed: () async {
                          await showLabelsBottomSheet(isSelection: true, alreadySelected: getSplitList(labels)).then((labelList) async {
                            if (labelList != null && labelList.isNotEmpty) {
                              await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'l', value: getJoinedList(labelList));
                            }
                          });
                        },
                        Icons.label_outlined,
                        color: styler.hoverActionsColor(bgColor),
                        tooltip: 'Reminder',
                        size: 18,
                      ),
                    //
                    // Sets reminder
                    //
                    if (showHoverOptions && !inSelection && !isDeleted)
                      AppIconButton(
                        onPressed: () async {
                          showSetReminderDialog(reminder: reminder).then((reminder) async {
                            if (reminder != null) {
                              await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'r', value: reminder);
                            }
                          });
                        },
                        Icons.notifications_none_outlined,
                        color: styler.hoverActionsColor(bgColor),
                        tooltip: 'Reminder',
                        size: 18,
                      ),
                    //
                    // Color
                    //
                    if (showHoverOptions && !inSelection && !isDeleted)
                      AppIconButton(
                        onPressed: () async {
                          await showPickItemBgColor(color: color).then((color) async {
                            if (color != null) {
                              await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'c', value: color);
                            }
                          });
                        },
                        Icons.palette_outlined,
                        color: styler.hoverActionsColor(bgColor),
                        tooltip: 'Color',
                        size: 18,
                      ),
                    //
                    // Pin Item
                    //
                    if (showHoverOptions && !inSelection && !isDeleted)
                      AppIconButton(
                        onPressed: () async {
                          if (isPinned) {
                            await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'p', value: '0');
                          } else {
                            await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'p', value: '1');
                          }
                        },
                        isPinned ? Icons.push_pin_outlined : Icons.push_pin_rounded,
                        color: styler.hoverActionsColor(bgColor),
                        tooltip: isPinned ? 'Unpin' : 'Pin',
                        size: 18,
                      ),
                    //
                    // Restore Deleted Item
                    //
                    if (isDeleted && showHoverOptions && !inSelection)
                      AppIconButton(
                        onPressed: () async {
                          await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'x', value: '0');
                        },
                        FontAwesomeIcons.trashArrowUp,
                        color: styler.hoverActionsColor(bgColor),
                        tooltip: 'Restore From Trash',
                        size: textSizeNormal,
                      ),
                    //
                    // Delete item forever
                    //
                    if (isDeleted && showHoverOptions && !inSelection)
                      AppIconButton(
                        onPressed: () async {
                          await showConfirmationDialog(
                            title: 'Delete selected item forever?',
                            yeslabel: 'Delete',
                          ).then((value) async {
                            if (value == true) {
                              await deleteItemForever(context, where: type, action: typeActionsDelete[type], itemId: itemId);
                            }
                          });
                        },
                        Icons.delete_forever_rounded,
                        color: styler.hoverActionsColor(bgColor),
                        tooltip: 'Delete Forever',
                      ),
                    //
                    //
                    //
                    if (showHoverOptions && !inSelection && !isDeleted) HoverActionsMore(itemId: itemId, type: type, bgColor: bgColor),
                    //
                    //
                    //
                  ],
                ),
              ),
              //
              // If on horizontal list layout, we show a pinned icon for pinned lists
              //
              if (showPinned && !showHoverOptions)
                AppIcon(
                  Icons.more_horiz_rounded,
                  color: styler.hoverActionsColor(bgColor).withOpacity(0.2),
                  size: 18,
                ),
              //
              //
              //
            ],
          ),
        );
      }),
    );
  }
}
