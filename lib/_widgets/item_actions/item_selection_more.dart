import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';
import 'package:sessions/_widgets/menus/menu_item.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_helpers/edits/edit_item_extras.dart';
import '../../_providers/_provider_variables.dart';
import '../../_providers/common_providers/item_selection_provider.dart';
import '../../_variables/common_variables.dart';

class ItemSelectionMore extends StatelessWidget {
  const ItemSelectionMore({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();

    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      bool isArchive = labelsProviderX.selectedLabel == 'Archive';

      return AppPopupMenu(
          //
          menukey: menuKey,
          //
          // Shows selected view on the Header
          // Opens menu when pressed
          //
          menuButton: AppIconButton(
            onPressed: () => openPopupMenu(menuKey),
            Icons.more_vert_rounded,
            faded: true,
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
            ),
            //
            // Weekly View
            //
            popupMenuItem(
              label: 'Delete',
              onTap: () async {
                //pops menu
                popWhatsOnTop();

                selectionProvider.selectedItemMap.forEach((id, data) async {
                  await editItemExtras(where: data['type'], action: typeActionsEdit[data['type']], itemId: id, type: 'x', value: '1');
                });
                clearItemSelection();
              },
            ),
            //
            // Monthly View
            //
            popupMenuItem(
              label: 'Month',
              onTap: () async {
                //pops menu
                popWhatsOnTop();
              },
            ),
            //
            //
            //
          ]);
    });
  }
}
