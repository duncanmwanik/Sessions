import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_providers/common_providers/theme_provider.dart';
import '../../_widgets/components/icons.dart';
import '../../_widgets/components/text_styles.dart';
import '../_tables/_helpers/checks_table.dart';
import '_helpers/send_message.dart';

class MessageInputBar extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  MessageInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => isTableAdmin()
            ? Container(
                padding: EdgeInsets.only(left: 2, right: 2, bottom: 5, top: 5),
                color: styler.primaryColor(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //
                    // Add Attachment Button
                    //
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
                        side: BorderSide.none,
                        minimumSize: Size(45, 45),
                      ),
                      onPressed: () async {},
                      child: AppIcon(Icons.add_rounded, size: 28),
                    ),
                    //
                    // Message Input Form
                    //
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            hideKeyboard();
                            String message = messageController.text.trim();
                            messageController.clear();
                            sendMessageToFirebase(message);
                            focusNode.unfocus();
                          },
                          controller: messageController,
                          focusNode: focusNode,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: kIsWeb ? TextInputAction.send : null,
                          minLines: 1,
                          maxLines: 8,
                          style: TextStyle(fontSize: textSizeNormal),
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            hintStyle: TextStyle(fontSize: textSizeNormal),
                            filled: true,
                            fillColor: styler.secondaryColor(),
                            contentPadding: itemPadding(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: styler.borderColor(), width: 0.5),
                              borderRadius: BorderRadius.circular(borderRadiusMedium),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: styler.borderColor(), width: 0.5),
                              borderRadius: BorderRadius.circular(borderRadiusMedium),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //
                    // Send Button
                    //
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
                        side: BorderSide.none,
                        minimumSize: Size(45, 45),
                      ),
                      onPressed: () async {
                        hideKeyboard();
                        String message = messageController.text.trim();
                        messageController.clear();
                        sendMessageToFirebase(message);
                        focusNode.unfocus();
                      },
                      child: AppIcon(Icons.arrow_forward_rounded, size: 25),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(Icons.lock_rounded, size: 16, color: styler.textColorFaded()),
                    smallSpacerWidth(),
                    AppText(size: medium, text: 'Only admins can send messages', faded: true),
                  ],
                ),
              ));
  }
}
