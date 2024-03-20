import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_variables/common_variables.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../files/files_overview.dart';
import '../../_helpers/session_helpers.dart';
import '../../session_overview/dialog_session_overview.dart';

class SessionWidgetDaily extends StatelessWidget {
  const SessionWidgetDaily({super.key, required this.sessionData, required this.sessionId, required this.sessionDate});
  final Map sessionData;
  final String sessionId;
  final String sessionDate;

  @override
  Widget build(BuildContext context) {
    Color textColor = sessionColorList[int.parse(sessionData['c'])].textColor;

    return Theme(
      data: ThemeData(
        splashColor: styler.transparent,
        hoverColor: styler.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5, right: 10, left: 10),
        child: Material(
          color: styler.transparent,
          child: ListTile(
            tileColor: sessionColorList[int.parse(sessionData['c'])].color.withOpacity(0.9),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
            horizontalTitleGap: 0,
            minLeadingWidth: 25,
            minVerticalPadding: 1.2.h,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // Type
                //
                AppText(
                  size: small,
                  text: sessionTypeList[int.parse(sessionData['y'])],
                  fontWeight: FontWeight.w900,
                  textColor: sessionColorList[int.parse(sessionData['c'])].textColor,
                ),
                //
                tinySpacerHeight(),
                //
                // Title
                //
                AppText(size: normal, text: sessionData['t'], fontWeight: FontWeight.w700, textColor: textColor),
                //
                //
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //
                tinySpacerHeight(),
                //
                // Time
                //
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: sessionData['e'] != null ? 7 : 0),
                      child: AppText(
                        size: small,
                        text: get12HourTimeFrom24HourTime(sessionData['s'], islonger: true),
                        textColor: textColor,
                      ),
                    ),
                    AppText(
                      size: small,
                      text: (sessionData['e'] != null && sessionData['e'] != '') ? '-  ${get12HourTimeFrom24HourTime(sessionData['e'], islonger: true)}' : '',
                      textColor: textColor,
                    ),
                  ],
                ),
                //
                //
                tinySpacerHeight(),
                //
                //
                Wrap(
                  spacing: smallWidth(),
                  runSpacing: tinyHeight(),
                  children: [
                    //
                    // Lead
                    //
                    if (sessionData['l'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(FontAwesomeIcons.solidUser, size: 9, color: textColor),
                          tinySpacerWidth(),
                          Flexible(child: AppText(size: small, text: '${sessionData['l']}', textColor: textColor)),
                        ],
                      ),
                    //
                    // Venue
                    //
                    if (sessionData['v'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(FontAwesomeIcons.locationDot, size: 9, color: textColor),
                          tinySpacerWidth(),
                          Flexible(child: AppText(size: small, text: '${sessionData['v']}', textColor: textColor)),
                        ],
                      ),
                    //
                    //
                    //
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilesOverview(fileData: sessionData, color: textColor, textSize: small),
                      ],
                    ),

                    //
                    //
                    //
                  ],
                ),
              ],
            ),
            onTap: () {
              updateSelectedDate(sessionDate);
              updateSelectedSession(sessionId: sessionId, sessionData: sessionData);
              showSessionOverviewDialog(sessionDate: sessionDate, sessionId: sessionId, sessionData: sessionData);
            },
            onLongPress: () {
              closeBottomSheetIfOpen();
              updateSelectedDate(sessionDate);
              updateSelectedSession(sessionId: sessionId, sessionData: sessionData);
              prepareSessionEditing(sessionDate: sessionDate, sessionData: sessionData);
            },
          ),
        ),
      ),
    );
  }
}
