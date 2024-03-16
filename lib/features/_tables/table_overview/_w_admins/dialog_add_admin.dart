import 'package:flutter/material.dart';

import '../../../../_widgets/dialogs/action_buttons.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../_helpers/admin_helpers.dart';
import '../../table_management/_w/input_text.dart';

Future showAddAdminDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Enter the user email',
    content: TextInput('Email', nameController, TextInputType.text),
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(
          label: 'Add',
          onPressed: (() async {
            await addAdminToTable(nameController.text.trim());
          })),
    ],
  );
}
