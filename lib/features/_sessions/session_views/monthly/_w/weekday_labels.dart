import 'package:flutter/material.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_variables/date_time_variables.dart';
import '../../../../../_widgets/components/text_styles.dart';

class MonthlyWeekdayLabels extends StatelessWidget {
  const MonthlyWeekdayLabels({Key? key, this.isInitials = false}) : super(key: key);

  final bool isInitials;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: itemPaddingSmall(top: true),
      child: Row(
        children: List.generate(
          7,
          (index) => Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: itemPaddingSmall(top: true, bottom: true),
                      child: AppText(
                        size: 10,
                        text: isInitials ? weekDaysList[index].superShortName : weekDaysList[index].shortNameCap,
                        textAlign: TextAlign.center,
                        faded: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
