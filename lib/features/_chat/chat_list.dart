import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/user/user_info.dart';
import '../../_widgets/others/empty_box.dart';
import '../_tables/_helpers/get_table_data.dart';
import '_w/incoming_bubble.dart';
import '_w/sent_bubble.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentUserName = getCurrentUserName();

    return ValueListenableBuilder(
        valueListenable: Hive.box('${currentSelectedTable()}_chats').listenable(),
        builder: (context, box, widget) {
          if (box.keys.toList().isNotEmpty) {
            List chatIds = box.keys.toList();
            List reversedChatIds = chatIds.reversed.toList();

            return ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: reversedChatIds.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 10, bottom: 5),
                itemBuilder: (BuildContext context, int index) {
                  String messageId = reversedChatIds[index];
                  Map messageData = json.decode(box.get(messageId));
                  String userName = messageData['u'] ?? 'User';
                  String message = messageData['m'];

                  return (userName == currentUserName)
                      ? SentMessageBubble(
                          messageId: messageId,
                          message: message,
                          userName: userName,
                          onTap: () {},
                        )
                      : IncomingMessageBubble(
                          messageId: messageId,
                          message: message,
                          userName: userName,
                        );
                });
          } else {
            return EmptyBox(label: 'No new messages');
          }
        });
  }
}
