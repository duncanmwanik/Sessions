import 'package:flutter/material.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';
import 'package:sessions/_widgets/menus/menu_item.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_helpers/user/user_actions.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_helpers/checks_table.dart';
import '../../_helpers/delete_table.dart';

class TableOptions extends StatelessWidget {
  const TableOptions({Key? key, required this.tableId, required this.tableName, required this.tableGroupName}) : super(key: key);

  final String tableId;
  final String tableName;
  final String tableGroupName;

  @override
  Widget build(BuildContext context) {
    return AppPopupMenu(
      //
      menuButton: Padding(padding: EdgeInsets.all(10), child: AppIcon(Icons.more_horiz_rounded, faded: true)),
      //
      menuItems: [
        //
        // Add Table to Group
        //
        popupMenuItem(
          label: 'Add To Group',
          iconData: Icons.drive_folder_upload_rounded,
          onTap: () => addTableToGroup(tableId),
        ),
        //
        // Remove Table from Group if in any(groupNames is not empty)
        //
        if (tableGroupName.isNotEmpty)
          popupMenuItem(
            label: 'Remove From Group',
            iconData: Icons.folder_off_rounded,
            onTap: () => removeTableFromGroup(tableId, tableGroupName),
          ),
        //
        // Remove Table for user
        //
        PopupMenuItem(
          height: 0,
          enabled: false,
          padding: EdgeInsets.zero,
          child: FutureBuilder(
              future: isTableOwner(tableId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NoWidget();
                  } else if (snapshot.hasData) {
                    final isOwner = snapshot.data as bool;

                    return isOwner
                        ? NoWidget()
                        : popupMenuItem(
                            label: 'Remove Table',
                            iconData: Icons.remove_circle_outlined,
                            onTap: () => removeTable(tableId: tableId, tableName: tableName),
                          );
                  }
                }
                return LinearProgressIndicator(color: styler.textColorFaded());
              }),
        ),
        //
        // Delete Table for user
        //
        PopupMenuItem(
          height: 0,
          enabled: false,
          padding: EdgeInsets.zero,
          child: FutureBuilder(
              future: isTableOwner(tableId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NoWidget();
                  } else if (snapshot.hasData) {
                    final isOwner = snapshot.data as bool;

                    return isOwner
                        ? popupMenuItem(
                            label: 'Delete Table',
                            iconData: Icons.delete_forever_rounded,
                            onTap: () => deleteTable(tableId: tableId, tableName: tableName),
                          )
                        : NoWidget();
                  }
                }
                return LinearProgressIndicator(color: styler.textColorFaded());
              }),
        ),
        //
      ],
    );
  }
}
