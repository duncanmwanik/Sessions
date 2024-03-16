import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../../_config/styling/icons.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_providers/common_providers/views_provider.dart';
import '../../../_variables/common_variables.dart';
import '../../../_variables/navigation_variables.dart';
import 'others.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, viewsProvider, child) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: styler.isDarkTheme ? Colors.black26 : Colors.black12,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: viewsProvider.selectedHomeView,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            homeNavBarItem(
              viewsProvider.selectedHomeView == sessionsViewNo ? sessionsSelectedIcon : sessionsUnselectedIcon,
              navBatItems[sessionsViewNo],
              viewsProvider.selectedHomeView == sessionsViewNo,
            ),
            homeNavBarItem(
              viewsProvider.selectedHomeView == notesViewNo ? notesSelectedIcon : notesUnselectedIcon,
              navBatItems[notesViewNo],
              viewsProvider.selectedHomeView == notesViewNo,
            ),
            homeNavBarItem(
              viewsProvider.selectedHomeView == listsViewNo ? listsSelectedIcon : listsUnselectedIcon,
              navBatItems[listsViewNo],
              viewsProvider.selectedHomeView == listsViewNo,
            ),
            homeNavBarItem(
              viewsProvider.selectedHomeView == chatViewNo ? chatSelectedIcon : chatUnselectedIcon,
              navBatItems[chatViewNo],
              viewsProvider.selectedHomeView == chatViewNo,
            ),
            homeNavBarItem(
              viewsProvider.selectedHomeView == exploreViewNo ? exploreSelected : exploreUnSelected,
              navBatItems[exploreViewNo],
              viewsProvider.selectedHomeView == exploreViewNo,
            ),
          ],
          onTap: (viewNo) async {
            if (viewNo != viewsProvider.selectedHomeView) {
              clearItemSelection();
              homeTabController.animateTo(viewNo);
              viewsProvider.updateHomeView(viewNo);
            }
          },
        ),
      );
    });
  }
}

class WebHomeNavBar extends StatelessWidget {
  const WebHomeNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, viewsProvider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          webHomeNavItem(
            viewsProvider.selectedHomeView == sessionsViewNo ? sessionsSelectedIcon : sessionsUnselectedIcon,
            sessionsViewNo,
            viewsProvider.selectedHomeView == sessionsViewNo,
          ),
          mediumSpacerWidth(),
          webHomeNavItem(
            viewsProvider.selectedHomeView == notesViewNo ? notesSelectedIcon : notesUnselectedIcon,
            notesViewNo,
            viewsProvider.selectedHomeView == notesViewNo,
          ),
          mediumSpacerWidth(),
          webHomeNavItem(
            viewsProvider.selectedHomeView == listsViewNo ? listsSelectedIcon : listsUnselectedIcon,
            listsViewNo,
            viewsProvider.selectedHomeView == listsViewNo,
          ),
          mediumSpacerWidth(),
          webHomeNavItem(
            viewsProvider.selectedHomeView == chatViewNo ? chatSelectedIcon : chatUnselectedIcon,
            chatViewNo,
            viewsProvider.selectedHomeView == chatViewNo,
          ),
          mediumSpacerWidth(),
          webHomeNavItem(
            viewsProvider.selectedHomeView == exploreViewNo ? exploreSelected : exploreUnSelected,
            exploreViewNo,
            viewsProvider.selectedHomeView == exploreViewNo,
          ),
        ],
      );
    });
  }
}
