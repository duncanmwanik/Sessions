import 'package:flutter/material.dart';

import 'monthly_box.dart';

class MonthDaySessionList extends StatelessWidget {
  const MonthDaySessionList({Key? key, required this.todaySessionsMap}) : super(key: key);

  final Map todaySessionsMap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: todaySessionsMap.length,
            itemBuilder: (context, index) {
              String key = todaySessionsMap.keys.toList()[index];
              Map sessionData = todaySessionsMap[key];

              return SessionWidgetMonthly(sessionData: sessionData);
            }));
  }
}
