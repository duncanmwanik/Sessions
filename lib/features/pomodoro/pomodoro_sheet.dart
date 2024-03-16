import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/features/pomodoro/_w/stop_all.dart';
import 'package:sessions/features/pomodoro/period.dart';

import '../../_widgets/components/bottom_sheet.dart';
import '_w/appbar.dart';

Future<void> showPomodoroBottomSheet() async {
  await showAppBottomSheet(
    //
    // Header
    //
    header: PomodoroAppBar(),
    //
    //
    // Content
    //
    content: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          //
          //
          PomodoroPeriod(type: 'focus'),
          //
          //
          mediumSmallSpacerHeight(),
          //
          //
          PomodoroPeriod(type: 'break'),
          //
          //
          mediumSmallSpacerHeight(),
          //
          //
          PomodoroPeriod(type: 'longBreak'),
           //
          //
          mediumSmallSpacerHeight(),
          //
          //
          StopAllButton( ),
          //
          //
        ],
      ),
    ),
    //
    //
    whenComplete: () {},
    //
    //
  );
}
