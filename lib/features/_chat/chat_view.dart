import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../_tables/_helpers/checks_table.dart';
import 'chat_list.dart';
import 'input_bar.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: webMaxConstraints(),
      child: Column(
        children: [
          //
          //
          //
          Expanded(child: ChatList()),
          //
          //
          //
          if (isThereATableSelected()) MessageInputBar(),
          //
          //
          //
        ],
      ),
    );
  }
}
