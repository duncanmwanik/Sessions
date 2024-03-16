import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> deleteMessageForUser(BuildContext context, String messageId) async {
  try {
    await showConfirmationDialog(title: 'Delete message for me?', yeslabel: 'Delete').then((value) async {
      if (value == true) {
        await Hive.box('${currentSelectedTable()}_chats').delete(messageId);
        await pendingTableBox.delete(messageId);
      }
    });
  } catch (e) {
    //
  }
}
