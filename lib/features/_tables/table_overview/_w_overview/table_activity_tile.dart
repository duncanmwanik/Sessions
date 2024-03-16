import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../activity_sheet.dart';

class TableActivityTile extends StatelessWidget {
  const TableActivityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onTap: () async {
          showActivityBottomSheet();
        },
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_rounded),
            SizedBox(width: smallWidth()),
            Flexible(
              child: Text(
                'Activity History',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSizeMedium),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right_rounded));
  }
}
