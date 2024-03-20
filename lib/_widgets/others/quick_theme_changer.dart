import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../_helpers/_common_helpers/global_helper.dart';
import '../components/buttons.dart';
import '../menus/app_popup_menu.dart';
import '../menus/menu_item.dart';

class QuickThemeChanger extends StatelessWidget {
  const QuickThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();

    return AppPopupMenu(
        //
        menukey: menuKey,
        //
        menuButton: AppButton(
          onPressed: () => openPopupMenu(menuKey),
          isRound: true,
          noStyling: true,
          child: AppIcon(Icons.wb_sunny_rounded, faded: true),
        ),
        menuItems: [
          //
          popupMenuItemForThemes(),
          //
        ]);
  }
}
