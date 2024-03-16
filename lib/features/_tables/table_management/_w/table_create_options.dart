import 'package:flutter/material.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/menus/menu_item.dart';
import '../../_helpers/table_helpers.dart';
import 'dialog_add_table.dart';
import 'dialog_create_group.dart';

class CreateOptions extends StatelessWidget {
  const CreateOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();

    return AppPopupMenu(
      //
      menukey: menuKey,
      //
      menuButton: AppButton(
        onPressed: () => openPopupMenu(menuKey),
        smallLeftPadding: true,
        child: Row(
          children: [
            AppIcon(Icons.add_circle_rounded),
            smallSpacerWidth(),
            AppText(size: medium, text: 'Create'),
          ],
        ),
      ),
      //
      menuItems: [
        //
        // Delete aCreate
        //
        popupMenuItem(
          label: 'Create Table',
          iconData: Icons.add_rounded,
          onTap: () => prepareTableForCreation(),
        ),
        popupMenuItem(
          label: 'Create Group',
          iconData: Icons.create_new_folder_rounded,
          onTap: () => showCreateGroupDialog(),
        ),
        popupMenuItem(
          label: 'Add Table (Table ID)',
          iconData: Icons.add_circle_outline_rounded,
          onTap: () => showAddTableDialog(),
        ),
        //
      ],
    );
  }
}
