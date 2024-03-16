import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/others/scroll.dart';

import '../../../_providers/common_providers/views_provider.dart';
import 'daily/daily_view.dart';
import 'info_header.dart';
import 'monthly/monthly_view.dart';
import 'weekly/weekly_view.dart';
import 'yearly/yearly_view.dart';

class SessionViewSelector extends StatelessWidget {
  SessionViewSelector({Key? key}) : super(key: key);

  final List sessionViews = [
    DailyView(),
    WeeklyView(),
    MonthlyView(),
    YearlyView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(
      builder: (context, viewsProvider, child) => Column(
        children: [
          InfoHeader(),
          Expanded(
            child: ScrollConfiguration(
              behavior: AppScrollBehavior().copyWith(overscroll: false),
              child: sessionViews[viewsProvider.selectedSessionView],
            ),
          ),
        ],
      ),
    );
  }
}
