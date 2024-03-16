import 'package:flutter/material.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/pending/pending_actions.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../_helpers/checks.dart';
import '../_helpers/delete_message.dart';

class SentMessageBubble extends StatelessWidget {
  const SentMessageBubble({super.key, required this.messageId, required this.message, required this.userName, this.onTap});
  final String messageId;
  final String message;
  final String userName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        deleteMessageForUser(context, messageId);
      },
      //
      // The Row minimizes the chat box horizontally
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxChatWidth(), minWidth: 55),
              margin: itemMargin(top: true, right: true),
              padding: itemPadding(top: true, left: true, right: true),
              decoration: BoxDecoration(
                color: styler.chatBubbleColor(isSent: true),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadiusMedium),
                  bottomLeft: Radius.circular(borderRadiusMedium),
                  bottomRight: Radius.circular(borderRadiusMedium),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  // Sent Status Icon
                  //
                  AppIcon(
                      isBeingSent(messageId)
                          ? Icons.more_horiz_rounded
                          : isPendingItem(messageId)
                              ? Icons.refresh_rounded
                              : Icons.done_rounded,
                      size: 15,
                      color: Colors.black),
                  //
                  //
                  //
                  smallSpacerHeight(),
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
