import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../_helpers/user/user_info.dart';
import '../../../_widgets/components/list_tile.dart';
import '../../../_widgets/components/text_styles.dart';
import '../edit_details.dart';
import 'list_tile_widgets.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(getCurrentUserId()).listenable(),
        builder: (context, box, widget) {
          return Column(
            children: [
              //
              SettingTitle('ACCOUNT'),
              //
              smallSpacerHeight(),
              //
              AppListTile(
                leading: AppText(size: medium, text: 'Name'),
                trailing: AppText(size: medium, text: getCurrentUserName()),
                onTap: () {},
              ),
              //
              smallSpacerHeight(),
              //
              AppListTile(
                leading: AppText(size: medium, text: 'Email'),
                trailing: AppText(size: medium, text: getCurrentUserEmail()),
                onTap: () {},
              ),
              //
              smallSpacerHeight(),
              //
              AppListTile(
                leading: AppText(size: medium, text: 'Edit Account Details'),
                trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: normal),
                onTap: () => showEditDetailsBottomSheet(context),
              ),
              //
            ],
          );
        });
  }
}
