import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_helpers/_common_helpers/navigation_helper.dart';
import 'package:sessions/_variables/common_variables.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/features/_sessions/session_views/_w/view_chooser.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/date_time/datetime_helper.dart';
import '../../../_helpers/date_time/jump_to_date.dart';
import '../../../_providers/common_providers/datetime_provider.dart';
import '../../../_providers/common_providers/theme_provider.dart';
import '../../../_providers/common_providers/views_provider.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/components/tooltip.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DateTimeProvider, ViewsProvider, ThemeProvider>(builder: (context, dateProvider, viewsProvider, themeProvider, child) {
      DateInfo date = DateInfo(dateTime: dateProvider.selectedDate);
      bool isToday = [date.isToday(), false, date.isCurrentMonth(), date.isCurrentYear()][viewsProvider.selectedSessionView];
      List infoList = [
        getDayInfo(dateProvider.selectedDate),
        getWeekInfo(dateProvider.currentWeekDates[0], dateProvider.currentWeekDates[6]),
        getMonthInfo(dateProvider.selectedYear, dateProvider.selectedMonth),
        dateProvider.selectedYear.toString(),
      ];

      return Container(
        padding: EdgeInsets.only(left: 5, right: kIsWeb ? 15 : 10, bottom: 5, top: kIsWeb ? 5 : 0),
        // color: styler.primaryColor(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            //
            //
            // Left Actions -------------------------------------- start
            //
            //
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // Date Info
                  //
                  Flexible(
                    child: AppTooltip(
                      message: 'Jump to date',
                      child: ElevatedButton(
                        onPressed: () => jumpToDateDialog(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: styler.transparent,
                        ),
                        child: FittedBox(
                          child: AppText(
                            size: title,
                            text: infoList[viewsProvider.selectedSessionView],
                            fontWeight: isToday ? FontWeight.w900 : FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  //
                  smallSpacerWidth(),
                  //
                  // Change date buttons
                  //
                  if (kIsWeb)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        // Go to Previous date
                        AppButton(
                          isRound: true,
                          noStyling: true,
                          child: AppIcon(FontAwesomeIcons.angleLeft, size: 14),
                          onPressed: () {
                            if (viewsProvider.selectedSessionView == sessionsViewDailyNo) {
                              swipeToNewDay(direction: 'left', dateProvider);
                            }
                            if (viewsProvider.selectedSessionView == sessionsViewWeeklyNo) {
                              swipeToNewWeek(direction: 'left', dateProvider);
                            }
                            if (viewsProvider.selectedSessionView == sessionsViewMonthlyNo) {
                              swipeToNewMonth(direction: 'left', dateProvider);
                            }
                            if (viewsProvider.selectedSessionView == sessionsViewYearlyNo) {
                              swipeToNewYear(direction: 'left', dateProvider);
                            }
                          },
                        ),
                        //
                        // Go to Next date
                        AppButton(
                          isRound: true,
                          noStyling: true,
                          child: AppIcon(FontAwesomeIcons.angleRight, size: 14),
                          onPressed: () {
                            if (viewsProvider.selectedSessionView == sessionsViewDailyNo) {
                              swipeToNewDay(direction: 'right', dateProvider);
                            }
                            if (viewsProvider.selectedSessionView == sessionsViewWeeklyNo) {
                              swipeToNewWeek(direction: 'right', dateProvider);
                            }
                            if (viewsProvider.selectedSessionView == sessionsViewMonthlyNo) {
                              swipeToNewMonth(direction: 'right', dateProvider);
                            }
                            if (viewsProvider.selectedSessionView == sessionsViewYearlyNo) {
                              swipeToNewYear(direction: 'right', dateProvider);
                            }
                          },
                        ),
                        //
                        //
                      ],
                    ),
                  //
                  //
                  //
                ],
              ),
            ),
            //
            //
            //
            //
            //
            // Left Actions -------------------------------------- end
            //
            //
            //
            // Right Actions -------------------------------------- start
            //
            //
            //
            //
            //
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //
                  // Go to date today
                  //
                  //
                  AppTooltip(
                    message: getDateInfo(getDatePartFromDateTime(date.now)),
                    child: AppButton(
                      onPressed: () async {
                        if (!isToday) {
                          if (viewsProvider.selectedSessionView == 0) {
                            dateProvider.updateSelectedDate(getDatePartFromDateTime(date.now));
                            Scrollable.ensureVisible(GlobalObjectKey(TimeOfDay.now().hour).currentContext ?? context, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                          }
                          if (viewsProvider.selectedSessionView == 1) {
                            dateProvider.updateCurrentWeekDates(date.now);
                            Scrollable.ensureVisible(GlobalObjectKey(TimeOfDay.now().hour * 100).currentContext ?? context, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                          }
                          if (viewsProvider.selectedSessionView == 2) {
                            dateProvider.updateSelectedYear(date.now.year);
                            dateProvider.changeSelectedMonth(date.now.month);
                            await dateProvider.updateMonthDatesMap();
                          }
                          if (viewsProvider.selectedSessionView == 3) {
                            dateProvider.updateSelectedYear(date.now.year);
                            dateProvider.changeSelectedMonth(date.now.month);
                            await dateProvider.updateMonthDatesMap();
                          }
                        }
                      },
                      child: AppText(size: medium, text: 'Today'),
                    ),
                  ),
                  //
                  //
                  smallSpacerWidth(),
                  //
                  //
                  ViewChooser(),
                  //
                  //
                ],
              ),
            ),
            //
            //
            // Right Actions -------------------------------------- end
            //
            //
          ],
        ),
      );
    });
  }
}
