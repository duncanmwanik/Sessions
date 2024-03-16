import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';

import '../../../../_helpers/user/user_actions.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/menus/menu_item.dart';

class GroupOptions extends StatelessWidget {
  const GroupOptions({Key? key, required this.groupName}) : super(key: key);

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return AppPopupMenu(
      //
      menuButton: AppIcon(Icons.more_horiz_rounded, color: styler.textColorFaded()),
      //
      menuItems: [
        //
        // Delete a group
        //
        popupMenuItem(
          label: 'Delete Group',
          iconData: Icons.delete,
          onTap: () => deleteGroup(groupName),
        ),
        //
      ],
    );
  }
}
