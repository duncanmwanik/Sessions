import 'package:flutter/material.dart';

import '../../../_variables/navigation_variables.dart';
import '../../_chat/chat_view.dart';
import '../../_lists/list_view.dart';
import '../../_sessions/session_views/view_changer_session.dart';
import '../../explore/explore_view.dart';
import '../../notes/ntb_chooser.dart';

class HomeMobilelayout extends StatefulWidget {
  const HomeMobilelayout({Key? key}) : super(key: key);

  @override
  State<HomeMobilelayout> createState() => _HomeMobilelayoutState();
}

class _HomeMobilelayoutState extends State<HomeMobilelayout> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: homeTabController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SessionViewSelector(),
        NTViewChooser(),
        BoardView(),
        ChatView(),
        ExploreView(),
      ],
    );
  }
}
