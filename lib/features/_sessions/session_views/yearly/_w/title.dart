import 'package:flutter/material.dart';

import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/date_time/date_info.dart';
import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_widgets/components/text_styles.dart';

class YearViewTitle extends StatelessWidget {
  const YearViewTitle({Key? key, required this.date}) : super(key: key);

  final DateInfo date;

  @override
  Widget build(BuildContext context) {
    bool isToday = date.isToday();
    bool isSelectedMonth = isCurrentMonth(date.dateTime);

    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: isToday ? styler.accentColor() : styler.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: AppText(
          size: small,
          text: date.dayString(),
          fontWeight: isSelectedMonth ? FontWeight.w600 : null,
          textColor: isToday
              ? styler.white
              : isSelectedMonth
                  ? styler.textColor()
                  : styler.textColorFaded(),
        ),
      ),
    );
  }
}
