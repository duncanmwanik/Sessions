import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../_helpers/admin_helpers.dart';
import '../../_helpers/checks_table.dart';

class AdminChip extends StatelessWidget {
  const AdminChip({Key? key, required this.userEmail, required this.userId, required this.tableId}) : super(key: key);

  final String userEmail;
  final String userId;
  final String tableId;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: itemPadding(),
        margin: itemMargin(bottom: true),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          border: Border.all(color: styler.borderColor()),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(child: AppText(size: medium, text: userEmail)),
            Visibility(
              visible: isTableAdmin(),
              child: AppIconButton(
                onPressed: () async {
                  if (isTableAdmin()) {
                    await removeAdminFromTable(context, userId, userEmail);
                  }
                },
                Icons.close_rounded,
                color: styler.textColorFaded(),
              ),
            )
          ],
        ));
  }
}
