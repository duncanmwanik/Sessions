import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';
import 'package:sessions/_widgets/menus/menu_item.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_config/styling/helpers.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/edits/edit_item_extras.dart';
import '../../_providers/_provider_variables.dart';
import '../../_providers/common_providers/item_selection_provider.dart';
import '../../_variables/common_variables.dart';

class HoverActionsMore extends StatelessWidget {
  const HoverActionsMore({super.key, required this.itemId, required this.type, required this.bgColor});

  final String itemId;
  final String type;
  final String bgColor;

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();
    bool isColorInverted = hasBGColor(bgColor) || isImageTheme();

    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      bool isArchive = labelsProviderX.selectedLabel == 'Archive';

      return AppPopupMenu(
          //
          menukey: menuKey,
          //
          menuButton: AppIconButton(
            tooltip: 'More Actions',
            onPressed: () => openPopupMenu(menuKey),
            Icons.more_horiz_rounded,
            color: styler.textColorFaded(inverted: isColorInverted),
            size: 18,
          ),
          menuItems: [
            //
            // Daily View
            //
            popupMenuItem(
              label: isArchive ? 'Unarchive' : 'Archive',
              onTap: () async {
                //pops menu
                popWhatsOnTop();

                if (isArchive) {
                  await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'a', value: '0');
                } else {
                  await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'a', value: '1');
                }
              },
            ),
            //
            // Weekly View
            //
            popupMenuItem(
              label: 'Delete',
              onTap: () async {
                //pops menu
                popWhatsOnTop();

                await editItemExtras(where: type, action: typeActionsEdit[type], itemId: itemId, type: 'x', value: '1');
              },
            ),
            //
            //
            //
          ]);
    });
  }
}
