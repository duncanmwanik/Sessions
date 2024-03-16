import 'package:flutter/material.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_variables/common_variables.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/text_styles.dart';

AppBar settingsAppBar() {
  return AppBar(
    title: AppText(
      size: appBar,
      text: 'Account & Settings',
    ),
  );
}

class WebSettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WebSettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(maxWidth: webMaxWidth),
        height: kToolbarHeight,
        child: Row(
          children: [
            CustomCloseButton(),
            SizedBox(width: smallWidth()),
            AppText(
              size: appBar,
              text: 'Account & Settings',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(webAppBarWidth(), kToolbarHeight);
}

class EditDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditDetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(maxWidth: webMaxWidth),
        height: kToolbarHeight,
        child: Row(
          children: [
            CustomCloseButton(),
            smallSpacerWidth(),
            AppText(
              size: appBar,
              text: 'Edit Account Details',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(webAppBarWidth(), kToolbarHeight);
}
