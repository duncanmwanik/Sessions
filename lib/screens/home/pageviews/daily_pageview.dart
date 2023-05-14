import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/models/session_model.dart';
import 'package:sessions/screens/sessions/widgets/session_widget.dart';

import '../../../providers/datetime_provider.dart';
import '../../../variables/date_time_variables.dart';

class DailyPageView extends StatefulWidget {
  const DailyPageView({super.key});

  @override
  State<DailyPageView> createState() => _DailyPageViewState();
}

class _DailyPageViewState extends State<DailyPageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateTime, child) {
      Map todaySessionsMap = testData[dateTime.selectedDate] ?? {};
      // Map sortedSesionMapByTime = sortSessionsByTime(todaySessionsMap);
      // print(sortedSesionMapByTime);

      return ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) {
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      child: Row(
                        children: [
                          Text(
                            '${hours24to12[index] ?? 00} ',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          ))
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: todaySessionsMap.length,
                        itemBuilder: (BuildContext context, int index2) {
                          if (int.parse(todaySessionsMap[todaySessionsMap.keys.toList()[index2]]['time'].toString().split(':')[0]) == index) {
                            return SessionWidget(session: todaySessionsMap[todaySessionsMap.keys.toList()[index2]]);
                          } else {
                            return Container();
                          }
                        }),
                  ],
                );
              }),
        ],
      );
    });
  }
}
