import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_config/styling/helpers.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/edits/edit_item_extras.dart';
import '../../../_providers/common_providers/item_selection_provider.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../_tables/_helpers/checks_table.dart';
import 'dialog_create_list.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    required this.listId,
    required this.listData,
    this.isHorizontalView = false,
    this.showHoverOptions = false,
  }) : super(key: key);

  final String listId;
  final Map listData;
  final bool isHorizontalView;
  final bool showHoverOptions;

  @override
  Widget build(BuildContext context) {
    String listTitle = listData['t'] ?? '---';
    String bgColor = listData['c'] ?? 'x';
    bool isPinned = (listData['p'] ?? '0') == '1';

    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      bool isSelection = selectionProvider.selectedItemMap.isNotEmpty;
      bool isColorInverted = hasBGColor(bgColor) || isImageTheme();

      return InkWell(
        onTap: isTableAdmin()
            ? () {
                if (!isSelection) {
                  showCreateListDialog(isEdit: true, listData: listData, listId: listId);
                } else {
                  if (selectionProvider.selectedItemMap.containsKey(listId)) {
                    selectionProvider.removeFromSelectedItemMap(listId);
                  } else {
                    selectionProvider.addToSelectedItemMap(listId, listData['t'] ?? '', isPinned, 'lists');
                  }
                }
              }
            : () {},
        onLongPress: isTableAdmin()
            ? () {
                if (selectionProvider.selectedItemMap.containsKey(listId)) {
                  selectionProvider.removeFromSelectedItemMap(listId);
                } else {
                  selectionProvider.addToSelectedItemMap(listId, listData['t'] ?? '', isPinned, 'lists');
                }
              }
            : () {},
        hoverColor: styler.transparent,
        child: Row(
          mainAxisAlignment: showHoverOptions ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // List Name
            //
            Expanded(
              child: AppText(
                size: appBar,
                text: listTitle,
                textColor: styler.textColor(inverted: isColorInverted),
                overflow: TextOverflow.visible,
              ),
            ),
            //
            // Pinned Indicator
            //
            if (isPinned && isHorizontalView)
              AppIconButton(
                onPressed: isTableAdmin()
                    ? () async {
                        if (isPinned) {
                          await editItemExtras(where: 'lists', action: 'be', itemId: listId, type: 'p', value: '0');
                        } else {
                          await editItemExtras(where: 'lists', action: 'be', itemId: listId, type: 'p', value: '1');
                        }
                      }
                    : () {},
                Icons.push_pin,
                size: 14,
                noPadding: true,
                color: styler.textColor(inverted: isColorInverted),
              ),
            //
            //
            //
          ],
        ),
      );
    });
  }
}
