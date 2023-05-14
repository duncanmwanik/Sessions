import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

import '../../helpers/screen_size_helper.dart';
import 'widgets/bottom_navbar.dart';
import '../../variables/navigation_variables.dart';
import 'widgets/fab_new_session.dart';
import 'widgets/home_appbar.dart';
import 'pageviews/daily_pageview.dart';
import 'pageviews/history_pageview.dart';
import 'pageviews/monthly_pageview.dart';
import 'pageviews/weekly_pageview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getDeviceScreenDimensions(context);

    return Scaffold(
      appBar: homeAppbar(context, 'My Table'),
      body: ExpandablePageView(
        controller: pageViewController,
        pageSnapping: false,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          DailyPageView(),
          WeeklyPageView(),
          MonthlyPageView(),
          HistoryPageView(),
        ],
      ),
      floatingActionButton: NewSessionFAB(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
