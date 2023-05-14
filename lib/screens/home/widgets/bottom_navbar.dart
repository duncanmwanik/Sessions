import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/global_provider.dart';
import '../../../variables/navigation_variables.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  BottomNavigationBarItem bottomNavBarItem(IconData iconData, String label) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, global, child) {
      return BottomNavigationBar(
        currentIndex: global.selectedTab,
        items: <BottomNavigationBarItem>[
          bottomNavBarItem(Icons.view_day_rounded, 'Daily'),
          bottomNavBarItem(Icons.view_week_rounded, 'Weekly'),
          bottomNavBarItem(Icons.date_range_rounded, 'Monthly'),
          bottomNavBarItem(Icons.history_rounded, 'History'),
        ],
        onTap: (value) async {
          if (value != global.selectedTab) {
            global.updateSelectedTab(value);
            global.updateSelectedPageView(value);
            pageViewController.jumpToPage(value);
          }
        },
      );
    });
  }
}
