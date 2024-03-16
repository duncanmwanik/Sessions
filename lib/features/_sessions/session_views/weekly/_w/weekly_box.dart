import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/breakpoints.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_variables/common_variables.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../_state/session_provider.dart';
import '../../../session_overview/dialog_session_overview.dart';

class SessionWidgetWeekly extends StatelessWidget {
  const SessionWidgetWeekly({super.key, required this.sessionData, required this.sessionId, required this.sessionDate});

  final Map sessionData;
  final String sessionId;
  final String sessionDate;

  @override
  Widget build(BuildContext context) {
    Color textColor = sessionColorList[int.parse(sessionData['c'])].textColor;

    return Consumer<SessionProvider>(builder: (context, sessProv, child) {
      return Flexible(
        child: InkWell(
          onTap: () {
            updateSelectedDate(sessionDate);
            sessProv.updateSelectedSession(sessionData, sessionId);
            showSessionOverviewDialog(sessionDate: sessionDate, sessionId: sessionId, sessionData: sessionData);
          },
          borderRadius: BorderRadius.circular(borderRadiusTiny),
          child: Container(
            padding: EdgeInsets.all(5),
            margin: itemMarginMonthly(left: true, right: true),
            constraints: BoxConstraints(minHeight: 35, minWidth: double.maxFinite),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTiny),
              color: sessionColorList[int.parse(sessionData['c'])].color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                // Title
                //
                Flexible(
                  child: AppText(
                    size: small,
                    text: sessionData['t'],
                    overflow: TextOverflow.clip,
                    textColor: textColor,
                    maxlines: 1,
                  ),
                ),
                //
                // Time
                // Show only if screen width is large
                //
                if (isSmallPC())
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: sessionData['e'] != null ? 7 : 0),
                        child: AppText(size: small, text: get12HourTimeFrom24HourTime(sessionData['s']), textColor: textColor),
                      ),
                      AppText(
                        size: small,
                        text: (sessionData['e'] != null && sessionData['e'] != '') ? '-  ${get12HourTimeFrom24HourTime(sessionData['e'])}' : '',
                        textColor: textColor,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
