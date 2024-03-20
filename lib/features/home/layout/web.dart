import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_widgets/others/scroll.dart';

import '../../../_helpers/_common_helpers/theme_helper.dart';
import '../../../_variables/navigation_variables.dart';
import '../../_chat/chat_view.dart';
import '../../_lists/list_view.dart';
import '../../_sessions/session_views/view_changer_session.dart';
import '../../explore/explore_view.dart';
import '../../notes/ntb_chooser.dart';
import '../_w/appbar.dart';
import '../_web_layout/web_left_box.dart';

class HomeWeblayout extends StatelessWidget {
  const HomeWeblayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getDefaultThemeImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: ScrollConfiguration(
        behavior: AppScrollBehavior().copyWith(physics: BouncingScrollPhysics()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (showWebNavBox()) WebLeftBox(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBarHome(),
                  Expanded(
                    child: TabBarView(
                      controller: homeTabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SessionViewSelector(),
                        NTViewChooser(),
                        BoardView(),
                        ChatView(),
                        ExploreView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
