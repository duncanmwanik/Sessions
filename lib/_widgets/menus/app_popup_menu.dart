import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';
import 'custom_popup_menu.dart';

class AppPopupMenu extends StatelessWidget {
  const AppPopupMenu({Key? key, required this.menuButton, required this.menuItems, this.tooltip, this.menukey}) : super(key: key);

  final Widget menuButton;
  final List<PopupMenuEntry<Object?>> menuItems;
  final String? tooltip;
  final Key? menukey;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButtonX(
      key: menukey,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      tooltip: tooltip ?? 'Options',
      color: styler.secondaryColor(),
      surfaceTintColor: styler.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium - 3), // -3 aligns border with AppButtons
        side: BorderSide(color: Colors.blueGrey.withOpacity(0.1), width: 1.5),
      ),
      child: menuButton,
      itemBuilder: (context) => menuItems,
    );
  }
}
