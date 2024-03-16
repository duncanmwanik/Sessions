import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../../../_config/styling/breakpoints.dart';
import '../../../../_config/styling/icons.dart';
import '../../../../_config/styling/spacing.dart';
import '../../../../_providers/common_providers/global_provider.dart';
import '../../../../_providers/common_providers/views_provider.dart';
import '../../../../_variables/common_variables.dart';
import '../../_w/others.dart';
import 'toggle_left_box.dart';

class WebNavBox extends StatelessWidget {
  const WebNavBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, GlobalProvider>(builder: (context, viewsProvider, globalProvider, child) {
      bool showWebBoxOptions = kIsWeb && globalProvider.showWebBoxOptions;

      return Container(
        width: 50,
        padding: itemPaddingSmall(left: true, right: true),
        decoration: BoxDecoration(
          border: (!showWebBox() || !showWebBoxOptions) ? null : Border(right: BorderSide(color: styler.borderColor())),
        ),
        child: Column(
          children: [
            //
            webHomeNavItem(
              viewsProvider.selectedHomeView == sessionsViewNo ? sessionsSelectedIcon : sessionsUnselectedIcon,
              sessionsViewNo,
              viewsProvider.selectedHomeView == sessionsViewNo,
            ),
            //
            mediumSpacerHeight(),
            //
            webHomeNavItem(
              viewsProvider.selectedHomeView == notesViewNo ? notesSelectedIcon : notesUnselectedIcon,
              notesViewNo,
              viewsProvider.selectedHomeView == notesViewNo,
            ),
            //
            mediumSpacerHeight(),
            //
            webHomeNavItem(
              viewsProvider.selectedHomeView == listsViewNo ? listsSelectedIcon : listsUnselectedIcon,
              listsViewNo,
              viewsProvider.selectedHomeView == listsViewNo,
            ),
            //
            mediumSpacerHeight(),
            //
            webHomeNavItem(
              viewsProvider.selectedHomeView == chatViewNo ? chatSelectedIcon : chatUnselectedIcon,
              chatViewNo,
              viewsProvider.selectedHomeView == chatViewNo,
            ),
            //
            mediumSpacerHeight(),
            //
            webHomeNavItem(
              viewsProvider.selectedHomeView == exploreViewNo ? exploreSelected : exploreUnSelected,
              exploreViewNo,
              viewsProvider.selectedHomeView == exploreViewNo,
            ),
            //
            // Hide or Web Show Left Box
            //
            if (showWebBox()) ToggleWebLeftBox(),
            //
            //
            mediumSpacerHeight(),
            //
          ],
        ),
      );
    });
  }
}
