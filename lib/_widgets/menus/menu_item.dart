import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../_config/styling/styler.dart';
import '../components/icons.dart';

PopupMenuItem popupMenuItem({required String label, IconData? iconData, required Function() onTap, IconData? trailing}) {
  return PopupMenuItem(
    height: 0,
    enabled: false,
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: ListTile(
      onTap: () {
        popWhatsOnTop();
        // Future.delayed allows us to open Dialogs from the popup
        Future.delayed(Duration(seconds: 0), onTap);
      },
      dense: true,
      horizontalTitleGap: 0,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.symmetric(horizontal: kIsWeb && iconData != null ? 8 : 16, vertical: kIsWeb ? 2 : 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall + 3)),
      leading: iconData == null ? null : AppIcon(iconData),
      trailing: trailing == null ? null : AppIcon(trailing),
      title: Container(constraints: BoxConstraints(minWidth: 50), child: AppText(size: medium, text: label)),
    ),
  );
}

PopupMenuItem popupMenuItemForTheme({required String label, required String imagePath, Color color = Colors.white}) {
  return PopupMenuItem(
      height: 0,
      enabled: false,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        width: 150,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSmall + 3),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            AppText(size: medium, text: label, textColor: color),
            //
            //
            AppIcon(Icons.done_rounded, color: color),
            //
          ],
        ),
      ));
}

PopupMenuItem popupMenuItemSpacer({double height = 8}) {
  return PopupMenuItem(height: 0, enabled: false, padding: EdgeInsets.zero, child: SizedBox(height: height));
}
