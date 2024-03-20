import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/navigation_helper.dart';
import '../../../../_providers/common_providers/datetime_provider.dart';
import '../../../../_variables/date_time_variables.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../_tables/_helpers/get_table_data.dart';
import '../../_helpers/session_helpers.dart';
import '../../_helpers/sorting_sessions.dart';
import '../_w/daily_box.dart';

final ItemScrollController itemScrollController = ItemScrollController();

class DailyView extends StatelessWidget {
  const DailyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return ValueListenableBuilder(
          valueListenable: Hive.box(currentSelectedTable()).listenable(),
          builder: (context, box, widget) {
            String selectedDate = dateProvider.selectedDate;
            Map todaySessionsMap = sortSessionsByTime(box.get(selectedDate, defaultValue: {}));

            return GestureDetector(
              key: ValueKey(selectedDate),
              onHorizontalDragEnd: kIsWeb ? null : (details) => swipeToNewDay(details: details, dateProvider),
              child: ListView(
                shrinkWrap: true,
                children: [
                  //
                  //
                  //
                  ScrollablePositionedList.builder(
                    // initialScrollIndex: DateTime.now().hour,
                    itemScrollController: itemScrollController,
                    shrinkWrap: true,
                    itemCount: 24,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int indexHour) {
                      bool isCurrentHour = TimeOfDay.now().hour == indexHour;
                      Map hourMap = getHourMap(getNewMapFrom(todaySessionsMap), indexHour);

                      return Material(
                        color: styler.transparent,
                        child: InkWell(
                          onDoubleTap: () {
                            prepareSessionCreationFromDay(selectedDate, indexHour);
                          },
                          onLongPress: () {
                            prepareSessionCreationFromDay(selectedDate, indexHour);
                          },
                          hoverColor: hourMap.isNotEmpty ? styler.transparent : styler.appColor(1),
                          highlightColor: hourMap.isNotEmpty ? styler.transparent : styler.appColor(1),
                          child: Container(
                            padding: EdgeInsets.only(left: 3, right: 3, bottom: 5),
                            constraints: BoxConstraints(minHeight: 40),
                            child: Column(
                              // key: GlobalObjectKey(indexHour),
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //
                                //  Divider
                                //
                                if (indexHour != 0)
                                  Divider(
                                    height: 0,
                                    thickness: isCurrentHour ? 1 : 0.06,
                                    color: isCurrentHour ? styler.accentColor() : styler.textColor(),
                                  ),
                                //
                                if (indexHour != 0) tinySpacerHeight(),
                                //
                                //
                                //
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //
                                    // Hour Text
                                    //
                                    SizedBox(
                                      width: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10, top: 12),
                                        child: AppText(
                                          size: 10,
                                          text: '${hours24to12LabelShort[indexHour]} ${hours24to12Periods[indexHour]}',
                                          fontWeight: isCurrentHour ? FontWeight.w900 : FontWeight.w300,
                                          textColor: isCurrentHour ? styler.accentColor() : styler.textColorFaded(),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    //
                                    // List of Sessions
                                    //
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: hourMap.length,
                                          itemBuilder: (BuildContext context, int indexSessionId) {
                                            String sessionId = hourMap.keys.toList()[indexSessionId];
                                            Map sessionData = hourMap[sessionId];

                                            return SessionWidgetDaily(
                                              sessionData: sessionData,
                                              sessionId: sessionId,
                                              sessionDate: selectedDate,
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  //
                  //
                  //
                  smallSpacerHeight(),
                  smallPlaceHolderSpacerHeight(),
                  //
                  //
                  //
                ],
              ),
            );
          });
    });
  }
}
