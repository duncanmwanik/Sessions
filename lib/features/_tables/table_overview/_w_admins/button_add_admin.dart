import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import 'dialog_add_admin.dart';

class AddNewAdminButton extends StatelessWidget {
  const AddNewAdminButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
            ),
            onPressed: () async {
              await showAddAdminDialog();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add_rounded),
                tinySpacerWidth(),
                AppText(size: medium, text: 'Add Admin'),
              ],
            ))
      ],
    );
  }
}
