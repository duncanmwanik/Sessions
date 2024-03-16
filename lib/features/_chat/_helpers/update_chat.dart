import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/notifications/create_notification.dart';
import '../../../_services/cloud/firebase_database.dart';
import '../../_tables/_helpers/get_table_data.dart';

Future<void> updateChat(String tableId, String messageId) async {
  await cloudService.getDataStartAt('$tablesPathCloud/$tableId/chats', messageId).then((snapshot) async {
    Map newMessages = snapshot.value != null ? snapshot.value as Map : {};

    List chatData = [];

    newMessages.forEach((messageId, message) async {
      Map messageData = json.decode(message);
      String userName = messageData['u'] ?? 'User';
      String text = messageData['m'];
      chatData.add('<b>$userName</b>: $text');
      await Hive.box('${tableId}_chats').put(messageId, message);
    });

    showNotification(type: 'c', title: getTableName(tableId), body: chatData.join('<br>'), data: {'type': 'c'});
  });
}
