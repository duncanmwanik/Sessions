import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/features/_tables/_helpers/checks_table.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_widgets/components/toast.dart';
import '../../_tables/_helpers/get_table_data.dart';
import 'chat_helper.dart';

Future<void> sendMessageToFirebase(String message) async {
  try {
    if (message.isNotEmpty && isTableAdmin()) {
      String userName = getCurrentUserName();
      String tableId = currentSelectedTable();
      String messageId = getUniqueId();

      addToSendingChatsList(id: messageId);
      await Hive.box('${tableId}_chats').put(messageId, json.encode({'u': userName, 'm': message}));

      Map messageData = {
        messageId: json.encode({'u': userName, 'm': message})
      };

      syncToCloud(tableId: tableId, where: 'chats', itemId: messageId, isNew: true, action: 'cc', data: messageData);

      removeFromSendingChatsList(id: messageId);
    }
  } catch (e) {
    showToast(1, 'Message not sent. Tap to resend.');
    errorPrint('send-chat', e);
  }
}
