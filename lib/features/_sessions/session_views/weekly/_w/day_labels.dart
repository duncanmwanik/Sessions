import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_helpers/date_time/get_week_no.dart';
import '../../../../../_providers/common_providers/datetime_provider.dart';
import '../../../../../_variables/date_time_variables.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../../_tables/_helpers/get_table_data.dart';
import '../../../_helpers/sorting_sessions.dart';
import '../../_w/bottom_sheet_sessions_list.dart';

class WeekDayLabels extends StatelessWidget {
  const WeekDayLabels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(
      builder: (context, dateProvider, child) => Row(
        children: [
          //
          // Week No
          //
          SizedBox(
            width: 45,
            child: AppText(
              size: medium,
              text: getWeekNumber(dateProvider.currentWeekDates[3]).toString(),
              faded: true,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
          //
          // Week Days
          //
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(weekDaysList.length, (index) {
                  String date = getDatePartFromDateTime(dateProvider.currentWeekDates[index]);
                  bool isToday = date == getDatePartFromDateTime(DateTime.now());

                  return Expanded(
                    child: Material(
                      child: InkWell(
                        onTap: () async {
                          Map weekDaySessionsMap = sortSessionsByTime(Hive.box(currentSelectedTable()).get(date, defaultValue: {}));
                          showSessionListBottomSheet(date, weekDaySessionsMap);
                        },
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //
                              // Day Name
                              //
                              Flexible(child: AppText(size: tiny, text: weekDaysList[index].shortNameCap, faded: true)),
                              //
                              // Date No
                              //
                              Container(
                                padding: EdgeInsets.all(3),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isToday ? styler.accentColor() : Colors.transparent,
                                ),
                                child: Center(
                                  child: AppText(
                                    size: normal,
                                    text: dateProvider.currentWeekDates[index].day.toString(),
                                    textColor: isToday ? styler.white : styler.textColor(),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              tinySpacerHeight(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
