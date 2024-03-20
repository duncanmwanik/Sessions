import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/list_tile.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/menus/app_popup_menu.dart';
import '../../../_widgets/menus/menu_item.dart';
import 'list_tile_widgets.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();

    return Column(
      children: [
        //
        SettingTitle('THEME'),
        //
        smallSpacerHeight(),
        //
        AppPopupMenu(
          //
          menukey: menuKey,
          //
          menuButton: AppListTile(
            onTap: () => openPopupMenu(menuKey),
            leading: AppText(size: medium, text: 'Dark'),
            trailing: AppIcon(Icons.keyboard_arrow_right_rounded, size: normal),
          ),
          menuItems: [
            //
            popupMenuItemForThemes(),
            //
          ],
        ),
        //
      ],
    );
  }
}
