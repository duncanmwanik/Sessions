import 'package:flutter/material.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_widgets/components/text_styles.dart';
import '../_helpers/delete_message.dart';

class IncomingMessageBubble extends StatelessWidget {
  const IncomingMessageBubble({super.key, required this.messageId, required this.message, required this.userName});
  final String messageId;
  final String message;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        deleteMessageForUser(context, messageId);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxChatWidth(), minWidth: 55),
              margin: itemMargin(top: true, left: true),
              padding: itemPadding(),
              decoration: BoxDecoration(
                color: styler.chatBubbleColor(),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(borderRadiusMedium),
                  bottomLeft: Radius.circular(borderRadiusMedium),
                  bottomRight: Radius.circular(borderRadiusMedium),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Username
                  //
                  AppText(
                    size: small,
                    text: userName,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black,
                    overflow: TextOverflow.visible,
                  ),
                  //
                  //
                  smallSpacerHeight(),
                  //
                  // Message
                  //
                  AppText(
                    size: normal,
                    text: message,
                    textColor: Colors.black,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.visible,
                  ),
                  //
                  //
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
