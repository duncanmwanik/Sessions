import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_helpers/date_time/date_info.dart';
import 'package:sessions/_widgets/others/scroll.dart';
import 'package:sessions/features/_sessions/_helpers/session_helpers.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_helpers/_common_helpers/navigation_helper.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_providers/common_providers/datetime_provider.dart';
import '../../../_tables/_helpers/get_table_data.dart';
import '../../_helpers/sorting_sessions.dart';
import '../_w/bottom_sheet_sessions_list.dart';
import '_w/day_label.dart';
import '_w/list_of_sessions.dart';
import '_w/weekday_labels.dart';

class MonthlyView extends StatelessWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return GestureDetector(
        onHorizontalDragEnd: kIsWeb ? null : (details) => swipeToNewMonth(details: details, dateProvider),
        child: Column(
          children: [
            MonthlyWeekdayLabels(),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double height = constraints.maxHeight;
                  double width = kIsWeb ? constraints.maxWidth - 1 : constraints.maxWidth;

                  return ScrollConfiguration(
                    behavior: AppScrollBehavior().copyWith(scrollbars: false),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Wrap(
                          children: List.generate(42, (indexDate) {
                            String dateToday = getDatePartFromDateTime(dateProvider.monthDatesMap[indexDate]);
                            DateInfo date = DateInfo(dateTime: dateToday);

                            return ValueListenableBuilder(
                                valueListenable: Hive.box(currentSelectedTable()).listenable(),
                                builder: (context, box, widget) {
                                  Map todaySessionsMap = sortSessionsByTime(box.get(dateToday, defaultValue: {}));

                                  return Material(
                                    color: styler.transparent,
                                    child: InkWell(
                                      onTap: () => showSessionListBottomSheet(dateToday, todaySessionsMap),
                                      onDoubleTap: () => prepareSessionCreationFromDay(dateToday, TimeOfDay.now().hour),
                                      onLongPress: () => prepareSessionCreationFromDay(dateToday, TimeOfDay.now().hour),
                                      child: Container(
                                        width: width / 7,
                                        height: height / 6,
                                        constraints: BoxConstraints(minHeight: 70),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: styler.textColorFaded(), width: 0.06),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            MonthDayNumberLabel(date: date),
                                            MonthDaySessionList(todaySessionsMap: todaySessionsMap),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                        smallSpacerHeight(),
                        smallPlaceHolderSpacerHeight()
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
