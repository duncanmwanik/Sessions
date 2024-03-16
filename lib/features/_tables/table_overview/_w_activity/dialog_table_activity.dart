import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../_helpers/activity/delete_activity.dart';
import '../../../../_variables/common_variables.dart';
import '../../../../_widgets/dialogs/dialog_option_button.dart';

Future<bool?> showTableActivityDialog(BuildContext context, var box, String activityId) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        content: Container(
          width: double.maxFinite,
          constraints: kIsWeb ? BoxConstraints(maxWidth: webMaxDialogWidth) : BoxConstraints(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogOptionButton(
                    label: 'Delete Activity For Me',
                    iconData: Icons.delete,
                    onTap: () {
                      deleteActivityForUser(context, box, activityId);
                    }),
              ],
            ),
          ),
        ),
      );
    },
  );
}
