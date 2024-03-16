import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../../_config/styling/breakpoints.dart';
import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/_common_helpers/navigation_helper.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_providers/common_providers/datetime_provider.dart';
import '../../../../_variables/date_time_variables.dart';
import '../../../../_widgets/others/scroll.dart';
import '../../../_tables/_helpers/get_table_data.dart';
import '../../_helpers/session_helpers.dart';
import '../../_helpers/sorting_sessions.dart';
import '_w/current_hour_indicator.dart';
import '_w/day_labels.dart';
import '_w/weekly_box.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return GestureDetector(
        onHorizontalDragEnd: kIsWeb ? null : (details) => swipeToNewWeek(details: details, dateProvider),
        child: Column(
          children: [
            WeekDayLabels(),
            Expanded(
              child: ScrollConfiguration(
                behavior: AppScrollBehavior().copyWith(scrollbars: false),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 24,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int indexHour) {
                          bool isCurrentHour = TimeOfDay.now().hour == indexHour;

                          return Column(
                            // key: GlobalObjectKey(indexHour * 100),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              // Divider
                              //
                              if (indexHour != 0) Divider(height: 0, thickness: 0.06, color: styler.textColorFaded()),
                              //
                              //
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  // Hour Text
                                  //
                                  SizedBox(
                                    width: 42,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10, top: 12),
                                      child: AppText(
                                        size: tiny,
                                        text: '${hours24to12LabelShort[indexHour]} ${hours24to12Periods[indexHour]}',
                                        fontWeight: isCurrentHour ? FontWeight.w900 : FontWeight.w300,
                                        faded: !isCurrentHour,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                  //
                                  // List of Sessions
                                  //
                                  Expanded(
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: List.generate(7, (indexWeekDay) {
                                          String dateToday = getDatePartFromDateTime(dateProvider.currentWeekDates[indexWeekDay]);
                                          bool isToday = dateToday == getDatePartFromDateTime(DateTime.now());

                                          return ValueListenableBuilder(
                                              valueListenable: Hive.box(currentSelectedTable()).listenable(),
                                              builder: (context, box, widget) {
                                                Map todaySessionsMap = sortSessionsByTime(box.get(dateToday, defaultValue: {}));
                                                Map hourMap = getHourMap(getNewMapFrom(todaySessionsMap), indexHour);

                                                return Expanded(
                                                  child: InkWell(
                                                    onDoubleTap: () {
                                                      prepareSessionCreationFromDay(dateToday, indexHour);
                                                    },
                                                    onLongPress: () {
                                                      prepareSessionCreationFromDay(dateToday, indexHour);
                                                    },
                                                    hoverColor: hourMap.isNotEmpty ? styler.transparent : styler.hoverColor(),
                                                    highlightColor: hourMap.isNotEmpty ? styler.transparent : styler.hoverColor(),
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      constraints: BoxConstraints(minHeight: 36.7),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(color: styler.textColorFaded(), width: 0.06),
                                                          right: showWebBox() && indexWeekDay == 6 ? BorderSide(color: styler.textColorFaded(), width: 0.06) : BorderSide.none,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          //
                                                          // Indicates current hour
                                                          //
                                                          if (isCurrentHour && isToday) CurrentHourIndicator(),

                                                          //
                                                          // Session List
                                                          //
                                                          Flexible(
                                                            child: Column(
                                                              children: List.generate(hourMap.length, (indexSessionId) {
                                                                String sessionId = hourMap.keys.toList()[indexSessionId];
                                                                Map sessionData = hourMap[sessionId];

                                                                return SessionWidgetWeekly(
                                                                  sessionData: sessionData,
                                                                  sessionId: sessionId,
                                                                  sessionDate: dateToday,
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                    //
                    //
                    smallPlaceHolderSpacerHeight(),
                    //
                    //
                    //
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
