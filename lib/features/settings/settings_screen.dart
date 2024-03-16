import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../_config/styling/breakpoints.dart';
import '../../_config/styling/spacing.dart';
import '../../_variables/common_variables.dart';
import '../../_widgets/others/about_app.dart';
import '../../_widgets/others/scroll.dart';
import '_w/account_details.dart';
import '_w/account_support.dart';
import '_w/appbar.dart';
import '_w/theme_changer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb ? WebSettingsAppBar() : settingsAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: kIsWeb ? BoxConstraints(maxWidth: webMaxWidth) : BoxConstraints(),
          margin: showSheetAsDialog() ? itemPadding() : null,
          padding: showSheetAsDialog() ? itemPadding() : null,
          decoration: showSheetAsDialog()
              ? BoxDecoration(
                  color: styler.secondaryColor(),
                  borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
                  border: styler.lightBoxBorder(),
                )
              : null,
          child: ScrollConfiguration(
            behavior: AppScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              shrinkWrap: true,
              children: [
                //
                //
                AccountDetails(),
                //
                //
                ThemeChanger(),
                //
                //
                AccountSupport(),
                //
                //
                AboutApp(),
                //
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
