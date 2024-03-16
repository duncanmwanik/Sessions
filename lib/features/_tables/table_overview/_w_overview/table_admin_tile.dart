import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../_helpers/checks_table.dart';
import '../admins_sheet.dart';

class TableAdminTile extends StatelessWidget {
  const TableAdminTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onTap: () async {
          showAdminsBottomSheet(title: isTableAdmin() ? 'Manage Admins' : 'Table Admins');
        },
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.admin_panel_settings_rounded),
            SizedBox(width: smallWidth()),
            Flexible(
              child: Text(
                isTableAdmin() ? 'Manage Admins' : 'Table Admins',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right_rounded));
  }
}
