import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_widgets/components/bottom_sheet.dart';
import 'package:sessions/_widgets/others/scroll.dart';
import 'package:sessions/features/_sessions/new_session/_w/appbar.dart';
import 'package:sessions/features/_sessions/new_session/_w/files.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_widgets/components/icons.dart';
import '_w/about.dart';
import '_w/color.dart';
import '_w/date.dart';
import '_w/lead.dart';
import '_w/reminders.dart';
import '_w/time.dart';
import '_w/title.dart';
import '_w/type.dart';
import '_w/venue.dart';

Future<void> showSessionBottomSheet({required bool isNewSession}) async {
  await showAppBottomSheet(
    //
    // Header Actions
    //
    header: SessionsAppbar(isNewSession: isNewSession),
    //
    // Content
    //
    content: ScrollConfiguration(
      behavior: AppScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //
            NewSessionTitleTextForm(),
            //
            // Divider(height: 0),
            //
            smallSpacerHeight(),
            //
            NewSessionLeadTextForm(),
            //
            smallSpacerHeight(),
            //
            NewSessionVenueTextForm(),
            //
            smallSpacerHeight(),
            //
            NewSessionAboutTextForm(),
            //
            isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
            //
            NewSessionTimePicker(),
            //
            isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
            //
            if (isNewSession) NewSessionDatePicker(),
            //
            if (isNewSession) isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
            //
            NewSessionReminders(),
            //
            isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
            //
            //
            Row(
              children: [
                //
                AppIcon(Icons.extension_rounded, faded: true, size: 18),
                smallSpacerWidth(),
                //
                Wrap(
                  runSpacing: smallWidth(),
                  children: [
                    NewSessionTypePicker(),
                    //
                    smallSpacerWidth(),
                    //
                    NewSessionColorPicker(),
                    //
                  ],
                ),
              ],
            ),
            //
            //
            isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
            //
            //
            NewSessionFiles(),
            //
            //
            smallPlaceHolderSpacerHeight(),
          ],
        ),
      ),
    ),
    //
    //
    //
  );
}
