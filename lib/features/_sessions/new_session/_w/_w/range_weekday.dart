import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';

import '../../../../../_config/styling/styler.dart';
import '../../../../../_variables/date_time_variables.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../_state/session_input_provider.dart';

class DateRangeWeekday extends StatelessWidget {
  const DateRangeWeekday({Key? key, required this.weekdayNo}) : super(key: key);

  final int weekdayNo;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(
      builder: (context, inputProvider, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: AppButton(
          onPressed: () {
            if (inputProvider.dateRangeWeekDays.contains(weekdayNo)) {
              inputProvider.removeFromDateRangeWeekDays(weekdayNo);
            } else {
              inputProvider.addToDateRangeWeekDays(weekdayNo);
            }
          },
          color: inputProvider.dateRangeWeekDays.contains(weekdayNo) ? styler.accentColor() : styler.tertiaryColor(),
          child: AppText(
            size: normal,
            text: weekDaysList[weekdayNo].superShortName,
            textColor: inputProvider.dateRangeWeekDays.contains(weekdayNo) ? Colors.white : styler.textColor(),
          ),
        ),
      ),
    );
  }
}
