import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_providers/common_providers/global_provider.dart';
import 'package:sessions/_widgets/components/images.dart';
import 'package:sessions/_widgets/others/scroll.dart';
import 'package:sessions/features/home/_web_layout/_w_left_box/web_calendar.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_providers/common_providers/datetime_provider.dart';
import '../../../_providers/common_providers/views_provider.dart';
import '../../../_variables/common_variables.dart';
import '../../../_widgets/components/creator.dart';
import '../../../_widgets/components/text_styles.dart';
import '_w_left_box/web_labels.dart';
import '_w_left_box/web_nav_box.dart';

class WebLeftBox extends StatelessWidget {
  const WebLeftBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<DateTimeProvider, ViewsProvider, GlobalProvider>(builder: (context, dateProvider, viewsProvider, globalProvider, child) {
      bool showWebBoxOptions = kIsWeb && globalProvider.showWebBoxOptions;
      bool showCalendar = [sessionsViewNo, chatViewNo, exploreViewNo].contains(viewsProvider.selectedHomeView);
      bool showLabelManager = [notesViewNo, listsViewNo].contains(viewsProvider.selectedHomeView);

      return Container(
        width: showWebBoxOptions ? 251 : 51,
        height: double.maxFinite,
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: styler.borderColor())),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            //
            Padding(
              padding: const EdgeInsets.only(top: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Sayari Branding
                  //
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //
                        // App Icon
                        AppImage(imagePath: 'assets/images/trw.png', size: 25),
                        //
                        if (showWebBoxOptions) smallSpacerWidth(),
                        //
                        if (showWebBoxOptions) AppText(size: large, text: 'Sayari', fontWeight: FontWeight.w700),
                        //
                      ],
                    ),
                  ),
                  //
                  mediumSpacerHeight(),
                  mediumSmallSpacerHeight(),
                  //
                  // Create New Item Button
                  //
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: showWebBoxOptions ? 12 : 0),
                    child: WebCreator(isCollapsed: !showWebBoxOptions),
                  ),
                  //
                  mediumSpacerHeight(),
                ],
              ),
            ),
            //
            //
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Navigation Icon Buttons
                  //
                  WebNavBox(),
                  //
                  // Tiny Calendar, Labels or ...
                  //
                  if (showWebBoxOptions)
                    Container(
                      width: 200,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadiusSmall)),
                      ),
                      child: ScrollConfiguration(
                        behavior: AppScrollBehavior().copyWith(scrollbars: false),
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          children: [
                            //
                            //
                            if (showCalendar) WebCalendar(),
                            //
                            //
                            if (showLabelManager) WebLabels(),
                            //
                            //
                          ],
                        ),
                      ),
                    ),
                  //
                  //
                ],
              ),
            ),
            //
            //
          ],
        ),
      );
    });
  }
}
