import 'package:flutter/material.dart';

import '../../../../_helpers/user/user_actions.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/dialogs/dialog_buttons.dart';
import 'input_text.dart';

Future<dynamic> showCreateGroupDialog() {
  final TextEditingController nameController = TextEditingController();

  return showAppDialog(
    title: 'Create New Group',
    content: TextInput('Name', nameController, TextInputType.name, autoFocus: true),
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(
          label: 'Create',
          onPressed: (() async {
            await createGroup(nameController.text.trim());
          })),
    ],
  );
}
