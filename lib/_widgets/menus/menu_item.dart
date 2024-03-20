import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_variables/common_variables.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../_config/styling/styler.dart';
import '../components/icons.dart';
import 'menu_item_theme.dart';

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

PopupMenuItem popupMenuItemForThemes() {
  return PopupMenuItem(
      height: 0,
      enabled: false,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 150,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: themeImages.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
          itemBuilder: (BuildContext context, int index) {
            String themeImage = themeImages.keys.toList()[index];
            String themeType = themeImages[themeImage] ?? 'light';

            return ThemeItem(themeImage: themeImage, themeType: themeType);
          },
        ),
      ));
}
