import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_helpers/date_time/date_info.dart';
import 'package:sessions/_helpers/date_time/month_helper.dart';
import 'package:sessions/_variables/date_time_variables.dart';
import 'package:sessions/_widgets/others/empty_box.dart';

import '../../../../_helpers/_common_helpers/navigation_helper.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_providers/common_providers/datetime_provider.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../_helpers/session_helpers.dart';
import '../_w/bottom_sheet_sessions_list.dart';
import '../monthly/_w/weekday_labels.dart';

class YearlyView extends StatelessWidget {
  const YearlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return GestureDetector(
        onHorizontalDragEnd: (details) => swipeToNewYear(details: details, dateProvider),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            //
            //
            //
            FutureBuilder(
                future: getAllMonthsDateMap(dateProvider.selectedYear),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return AppText(size: medium, text: '---');
                    } else if (snapshot.hasData) {
                      Map<int, Map<int, String>> allMonthsDateMap = snapshot.data as Map<int, Map<int, String>>;

                      return Align(
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          spacing: 3.w,
                          runSpacing: 3.w,
                          children: List.generate(12, (indexMonth) {
                            int month = indexMonth + 1;

                            Map<int, String> monthMap = allMonthsDateMap[indexMonth] ?? {};

                            return Container(
                              height: 45.w,
                              width: 45.w,
                              constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
                              child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                double height = constraints.maxHeight;
                                double width = constraints.maxWidth;

                                return Column(
                                  children: [
                                    AppText(size: small, text: monthNamesList[indexMonth]),
                                    smallSpacerHeight(),
                                    MonthlyWeekdayLabels(isInitials: true),
                                    Flexible(
                                      child: Wrap(
                                        children: List.generate(42, (indexDate) {
                                          DateInfo date = DateInfo(dateTime: monthMap[indexDate] ?? getDatePartFromDateTime(DateTime.now()));
                                          String dateToday = getDatePartFromDateTime(date.date);
                                          bool isSelectedMonth = date.month() == month;

                                          return InkWell(
                                              onTap: isSelectedMonth ? () => showSessionListBottomSheet(dateToday, {}) : null,
                                              onDoubleTap: isSelectedMonth ? () => prepareSessionCreationFromDay(dateToday, TimeOfDay.now().hour) : null,
                                              onLongPress: isSelectedMonth ? () => prepareSessionCreationFromDay(dateToday, TimeOfDay.now().hour) : null,
                                              child: SizedBox(
                                                width: width / 7.5,
                                                height: height / 6,
                                                child: Center(
                                                  child: AppText(
                                                    size: small,
                                                    text: date.dayString(),
                                                    textColor: isSelectedMonth ? null : styler.transparent,
                                                  ),
                                                ),
                                              ));
                                        }),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            );
                          }),
                        ),
                      );
                    }
                  }
                  return EmptyBox(label: '...');
                }),
            //
            //
            //
            largePlaceHolderHeight(),
            largePlaceHolderHeight(),
            //
            //
            //
          ],
        ),
      );
    });
  }
}
