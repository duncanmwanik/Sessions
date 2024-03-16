import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/others/empty_box.dart';

import '../../../../_config/styling/breakpoints.dart';
import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_widgets/components/bottom_sheet.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../_tables/_helpers/checks_table.dart';
import '../../_helpers/session_helpers.dart';
import 'daily_box.dart';

Future<void> showSessionListBottomSheet(String dateToday, Map todaySessionsMap) async {
  await showAppBottomSheet(
    //
    isMinimized: !showSheetAsDialog(),
    //
    // Header Actions
    //
    header: Row(
      children: [
        //
        Expanded(
          child: Row(
            children: [
              //
              CustomCloseButton(isX: true),
              //
              smallSpacerWidth(),
              //
              // Selected Date
              //
              AppText(size: normal, text: getDayInfoFullNames(dateToday)),
              //
            ],
          ),
        ),
        //
        // Create session on selected date
        //
        if (isThereATableSelected() && isTableAdmin())
          AppIconButton(
            tooltip: 'Create Session Here',
            onPressed: () {
              popWhatsOnTop();
              prepareSessionCreationFromDay(dateToday, TimeOfDay.now().hour);
            },
            Icons.add_rounded,
          ),
        //
        //
      ],
    ),
    //
    //
    // Content
    //
    content: todaySessionsMap.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: todaySessionsMap.length,
            itemBuilder: (context, index) {
              String key = todaySessionsMap.keys.toList()[index];
              Map sessionData = todaySessionsMap[key];

              return Padding(
                padding: EdgeInsets.only(bottom: index == (todaySessionsMap.length - 1) ? smallHeightPlaceHolder() : 0),
                child: SessionWidgetDaily(
                  sessionData: sessionData,
                  sessionId: todaySessionsMap.keys.toList()[index],
                  sessionDate: dateToday,
                ),
              );
            })
        : EmptyBox(label: 'No sessions today'),
    //
    //
    //
  );
}
