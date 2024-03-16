import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_providers/common_providers/item_selection_provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/delete_item_forever.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/edits/edit_item_extras.dart';
import '../../_providers/_provider_variables.dart';
import '../../_variables/common_variables.dart';
import '../../features/labels/bottom_sheet_labels.dart';
import '../../features/reminders/dialog_set_reminder.dart';
import '../components/icons.dart';
import '../components/text_styles.dart';
import '../dialogs/confirmation_dialog.dart';
import '../dialogs/dialog_item_bg_color.dart';
import 'item_selection_more.dart';

class SelectedItemOptions extends StatelessWidget {
  const SelectedItemOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      bool isArchive = labelsProviderX.selectedLabel == 'Archive';
      bool isTrash = labelsProviderX.selectedLabel == 'Trash';

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          //
          // Selected Count + Cancel Button
          //
          //
          //
          if (selectionProvider.selectedItemMap.isNotEmpty)
            AppButton(
              child: Row(
                children: [
                  // Clear Selection
                  AppIcon(Icons.close_rounded, faded: true),
                  //
                  smallSpacerWidth(),
                  //
                  // Shows No of selected items
                  AppText(
                    size: normal,
                    text: '${selectionProvider.selectedItemMap.length}',
                    textColor: styler.textColorFaded(),
                    fontWeight: FontWeight.w700,
                  ),
                  //
                ],
              ),
              onPressed: () => clearItemSelection(),
            ),
          //
          //
          //
          // Actions
          //
          //
          //
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (!isTrash)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //
                    // Sets Labels
                    //
                    AppIconButton(
                      onPressed: () async {
                        await showLabelsBottomSheet(isSelection: true).then((labelList) async {
                          if (labelList != null && labelList.isNotEmpty) {
                            selectionProvider.selectedItemMap.forEach((id, data) async {
                              //
                              // TODO: Add or remove label, do not overide
                              //
                              await editItemExtras(
                                where: data['type'],
                                action: typeActionsEdit[data['type']],
                                itemId: id,
                                type: 'l',
                                value: getJoinedList(labelList),
                              );
                            });
                          }
                        });
                        clearItemSelection();
                      },
                      Icons.label_outlined,
                      faded: true,
                      tooltip: 'Labels',
                    ),
                    //
                    // Sets reminder
                    //
                    AppIconButton(
                      onPressed: () async {
                        await showSetReminderDialog().then((reminder) async {
                          if (reminder != null) {
                            selectionProvider.selectedItemMap.forEach((id, data) async {
                              await editItemExtras(
                                where: data['type'],
                                action: typeActionsEdit[data['type']],
                                itemId: id,
                                type: 'r',
                                value: reminder,
                              );
                            });
                            clearItemSelection();
                          }
                        });
                      },
                      Icons.notifications_none,
                      faded: true,
                      tooltip: 'Reminder',
                    ),
                    //
                    // Color
                    //
                    AppIconButton(
                      onPressed: () async {
                        await showPickItemBgColor().then((color) async {
                          if (color != null) {
                            selectionProvider.selectedItemMap.forEach((id, data) async {
                              await editItemExtras(
                                where: data['type'],
                                action: typeActionsEdit[data['type']],
                                itemId: id,
                                type: 'c',
                                value: color,
                              );
                            });
                            clearItemSelection();
                          }
                        });
                      },
                      Icons.palette_outlined,
                      faded: true,
                      tooltip: 'Color',
                    ),
                    //
                    // Pin Items
                    //
                    AppIconButton(
                      onPressed: () {
                        selectionProvider.selectedItemMap.forEach((id, data) async {
                          //
                          // TODO: FIx pin logic
                          //
                          if (data['isPinned']) {
                            await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'p', value: '0');
                          } else {
                            await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'p', value: '1');
                          }
                        });
                        clearItemSelection();
                      },
                      Icons.push_pin_outlined,
                      faded: true,
                      tooltip: 'Pin Items',
                    ),
                    //
                    // Archive Items
                    //
                    if (!isPhone())
                      AppIconButton(
                        onPressed: () {
                          if (isArchive) {
                            selectionProvider.selectedItemMap.forEach((id, data) async {
                              await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'a', value: '0');
                            });
                          } else {
                            selectionProvider.selectedItemMap.forEach((id, data) async {
                              await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'a', value: '1');
                            });
                          }
                          clearItemSelection();
                        },
                        isArchive ? Icons.unarchive_outlined : Icons.archive_outlined,
                        faded: true,
                        tooltip: isArchive ? 'Unarchive' : 'Archive',
                      ),
                    //
                    // Delete Items
                    //
                    if (!isPhone())
                      AppIconButton(
                        onPressed: () {
                          selectionProvider.selectedItemMap.forEach((id, data) async {
                            await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'x', value: '1');
                          });
                          clearItemSelection();
                        },
                        Icons.delete_outlined,
                        faded: true,
                        tooltip: 'Delete',
                      ),
                  ],
                ),
              //
              //
              //
              if (isTrash)
                AppIconButton(
                  onPressed: () {
                    selectionProvider.selectedItemMap.forEach((id, data) async {
                      await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'x', value: '0');
                    });

                    clearItemSelection();
                  },
                  FontAwesomeIcons.trashArrowUp,
                  faded: true,
                  size: textSizeNormal,
                  tooltip: 'Restore From Trash',
                ),
              //
              //
              //
              if (isTrash)
                AppIconButton(
                  onPressed: () async {
                    await showConfirmationDialog(
                      title: 'Delete selected items forever?',
                      yeslabel: 'Delete',
                    ).then((value) async {
                      if (value == true) {
                        selectionProvider.selectedItemMap.forEach((id, data) async {
                          await deleteItemForever(
                            context,
                            where: data['type'],
                            action: typeActionsDelete[data['type']],
                            itemId: id,
                          );
                        });
                        clearItemSelection();
                      }
                    });
                  },
                  Icons.delete_forever_rounded,
                  faded: true,
                  tooltip: 'Delete Forever',
                ),
              //
              // Extra actions in menu if screen is not phone size
              //
              if (isPhone() && !isTrash) ItemSelectionMore(),
              //
              //
              //
            ],
          ),
          //
          //
          //
        ],
      );
    });
  }
}
