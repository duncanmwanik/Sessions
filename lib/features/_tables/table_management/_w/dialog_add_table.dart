import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../../_widgets/dialogs/action_buttons.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../_helpers/add_table_from_id.dart';
import 'input_text.dart';

Future<dynamic> showAddTableDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Add Table',
    content: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        TextInput('Table ID', nameController, TextInputType.name, autoFocus: true),
        smallSpacerHeight(),
        AppText(size: medium, text: 'You can get the Table ID from the table owner.', faded: true),
      ],
    ),
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(
          label: 'Add',
          onPressed: (() async {
            await addTableFromId(nameController.text.trim());
          })),
    ],
  );
}
