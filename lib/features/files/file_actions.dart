import 'package:flutter/material.dart';

import '../../../../_widgets/components/icons.dart';
import '../../_providers/_provider_variables.dart';
import '../../_widgets/menus/app_popup_menu.dart';
import '../../_widgets/menus/menu_item.dart';

class FileActions extends StatelessWidget {
  const FileActions({Key? key, required this.where, required this.fileId}) : super(key: key);

  final String where;
  final String fileId;

  @override
  Widget build(BuildContext context) {
    return AppPopupMenu(
      tooltip: 'File Options',
      menuButton: Padding(padding: EdgeInsets.symmetric(horizontal: 3), child: AppIcon(Icons.more_vert_rounded, size: 18)),
      menuItems: [
        //
        // Delete File
        //
        popupMenuItem(
          onTap: () {},
          label: 'Make Item Overview',
          iconData: Icons.image_rounded,
        ),
        //
        // Make file overview
        // TODO: Only images
        //
        popupMenuItem(
          onTap: () async {
            if (where == 'tasks') {
              taskInputProviderX.removeFromTaskInputData(fileId);
            }
            if (where == 'lists') {
              listInputProviderX.removeFromListInputData(fileId);
            }
            if (where == 'listItems') {
              listItemInputProviderX.removeFromListItemData(fileId);
            }
            if (where == 'sessions') {
              sessionInputProviderX.removeFromSessionInputData(fileId);
            }
          },
          label: 'Delete',
          iconData: Icons.delete_rounded,
        ),
        //
        // Remove Table for user
        //
      ],
    );
  }
}
