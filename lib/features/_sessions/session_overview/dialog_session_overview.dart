import 'package:flutter/material.dart';
import 'package:sessions/_widgets/dialogs/app_dialog.dart';
import 'package:sessions/_widgets/others/scroll.dart';
import 'package:sessions/features/_sessions/session_overview/_w/session_options.dart';
import 'package:sessions/features/_sessions/session_overview/_w/session_reminders.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_widgets/components/text_styles.dart';
import '_w/session_about.dart';
import '_w/session_files.dart';
import '_w/session_lead.dart';
import '_w/session_time.dart';
import '_w/session_type.dart';
import '_w/session_venue.dart';

Future showSessionOverviewDialog({required String sessionDate, required String sessionId, required Map sessionData}) {
  return showAppDialog(
    //
    smallTopPadding: true,
    //
    // Title
    //
    title: SessionType(sessionType: sessionData['y'], sessionColor: sessionData['c']),
    //
    // Content
    //
    content: ScrollConfiguration(
      behavior: AppScrollBehavior().copyWith(overscroll: false),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          //
          // Session Title
          //
          AppText(size: title, text: sessionData['t'], fontWeight: FontWeight.w700),
          //
          smallSpacerHeight(),
          //
          SessionTime(startTime: sessionData['s'], endTime: sessionData['e'] ?? ''),
          //
          if (sessionData['l'] != null) Divider(),
          if (sessionData['l'] != null) SessionLead(sessionLead: sessionData['l'] ?? ''),
          if (sessionData['v'] != null) Divider(),
          if (sessionData['v'] != null) SessionVenue(sessionVenue: sessionData['v'] ?? ''),
          if (sessionData['r'] != null) Divider(),
          if (sessionData['r'] != null) SessionReminders(reminderString: sessionData['r'] ?? ''),
          if (sessionData['a'] != null) Divider(),
          if (sessionData['a'] != null) SessionAbout(sessionAbout: sessionData['a'] ?? ''),
          if (sessionData['a'] != null) Divider(),
          //
          SessionFiles(),
          //
          smallSpacerHeight(),
          //
        ],
      ),
    ),
    //
    // Session Options
    //
    actions: [
      SessionOptions(sessionDate: sessionDate, sessionId: sessionId, sessionData: sessionData),
    ],
  );
}
