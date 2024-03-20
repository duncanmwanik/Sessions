import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/url_launcher_helper.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_widgets/components/list_tile.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../auth/_helpers/sign_out.dart';
import 'list_tile_widgets.dart';

class AccountSupport extends StatelessWidget {
  const AccountSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(getCurrentUserId()).listenable(),
        builder: (context, box, widget) {
          return Column(
            children: [
              //
              SettingTitle('SUPPORT'),
              //
              smallSpacerHeight(),
              //
              AppListTile(
                leading: AppText(size: medium, text: 'Sign Out'),
                trailing: AppIcon(Icons.exit_to_app_rounded, faded: true, size: normal),
                onTap: () => signOutUser(),
              ),
              //
              smallSpacerHeight(),
              //
              AppListTile(
                leading: AppText(size: medium, text: 'Send Feedback'),
                trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: normal),
                onTap: () => sendUserFeedbackViaEmail(),
              ),
              //
            ],
          );
        });
  }
}
