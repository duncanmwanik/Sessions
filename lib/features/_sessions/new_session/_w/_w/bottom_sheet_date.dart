import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/others/scroll.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../../_helpers/date_time/date_info.dart';
import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_variables/navigation_variables.dart';
import '../../../../../_widgets/components/icons.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../../../_widgets/components/toast.dart';
import '../../../_state/session_input_provider.dart';
import 'dialog_select_date_range.dart';
import 'range_weekday.dart';

Future<void> showDateRangeBottomSheet() async {
  await showModalBottomSheet(
      context: homeX.currentContext!,
      enableDrag: true,
      showDragHandle: true,
      backgroundColor: styler.secondaryColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadiusMedium), topRight: Radius.circular(borderRadiusMedium))),
      builder: (context) {
        return Consumer<SessionInputProvider>(builder: (context, inputProvider, child) {
          return Padding(
            padding: itemPaddingMedium(left: true, right: true),
            child: ScrollConfiguration(
              behavior: AppScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: smallWidth(),
                      children: [
                        //
                        // Start Date
                        //
                        AppButton(
                          onPressed: () async {
                            await showSelectDateRangeDialog(context, 'start');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HtmlText(text: 'Start Date: <b>${getDayInfo(inputProvider.dateRangeStart)}</b>'),
                              if (inputProvider.dateRangeStart.isEmpty) SizedBox(width: mediumWidth()),
                              if (inputProvider.dateRangeStart.isEmpty) AppIcon(Icons.calendar_month_rounded, tiny: true),
                            ],
                          ),
                        ),
                        //
                        // End Date
                        //
                        AppButton(
                          onPressed: () async {
                            await showSelectDateRangeDialog(context, 'end');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HtmlText(text: 'End Date: <b>${getDayInfo(inputProvider.dateRangeEnd)}</b>'),
                              if (inputProvider.dateRangeEnd.isEmpty) mediumSpacerWidth(),
                              if (inputProvider.dateRangeEnd.isEmpty) AppIcon(Icons.calendar_month_rounded, tiny: true),
                            ],
                          ),
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
                  Divider(),
                  //
                  AppText(size: medium, text: 'Repeats on', textAlign: TextAlign.center),
                  //
                  smallSpacerHeight(),
                  //
                  //
                  //
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) => DateRangeWeekday(weekdayNo: index)),
                  ),
                  //
                  //
                  //
                  mediumSpacerHeight(),
                  //
                  //
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        onPressed: () {
                          String start = inputProvider.dateRangeStart;
                          String end = inputProvider.dateRangeEnd;
                          if (start.isNotEmpty && end.isNotEmpty) {
                            if (DateTime.parse(start).isBefore(DateTime.parse(end))) {
                              List dates = getDaysInBetweenRange(DateTime.parse(start), DateTime.parse(end), inputProvider.dateRangeWeekDays);
                              for (String date in dates) {
                                if (!inputProvider.sessionSelectedDates.contains(date)) {
                                  inputProvider.addToSessionSelectedDates(date);
                                }
                              }
                              popWhatsOnTop();
                            } else {
                              showToast(0, 'Start date should come before end date!');
                            }
                          } else {
                            showToast(0, 'Enter start and end date');
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(Icons.done_rounded, tiny: true),
                            smallSpacerWidth(),
                            AppText(text: 'Done'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //
                  //
                  //
                  smallPlaceHolderSpacerHeight(),
                  //
                  //
                  //
                ],
              ),
            ),
          );
        });
      });
}
