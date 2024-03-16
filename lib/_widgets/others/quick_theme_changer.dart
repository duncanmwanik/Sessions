import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/theme_helper.dart';
import '../../_providers/common_providers/theme_provider.dart';
import '../components/buttons.dart';

class QuickThemeChanger extends StatelessWidget {
  const QuickThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final GlobalKey menuKey = GlobalKey();

    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      String theme = themeProvider.isDarkTheme;
      bool isDarkTheme = getThemeAsBoolean(theme);

      return Padding(
        padding: EdgeInsets.only(right: tinyWidth()),
        child: AppButton(
          onPressed: () {
            if (isDarkTheme) {
              themeProvider.enableDarkTheme('light');
            } else {
              themeProvider.enableDarkTheme('dark');
            }
          },
          isRound: true,
          noStyling: true,
          child: AppIcon(isDarkTheme ? Icons.wb_sunny_rounded : Icons.brightness_2_rounded, tiny: true),
        ),
      );

      // return AppPopupMenu(
      //     //
      //     menukey: menuKey,
      //     //
      //     // Shows selected view on the Header
      //     // Opens menu when pressed
      //     //
      //     menuButton: AppButton(
      //       onPressed: () => openPopupMenu(menuKey),
      //       isRound: true,
      //       noStyling: true,
      //       child: AppIcon(isDarkTheme ? Icons.wb_sunny_rounded : Icons.brightness_2_rounded, tiny: true),
      //     ),
      //     menuItems: [
      //       //
      //       popupMenuItemForTheme(label: 'Mars', imagePath: 'Assets/Images/planet.png'),
      //       //
      //       popupMenuItemSpacer(),
      //       //
      //       popupMenuItemForTheme(label: 'Jupiter', imagePath: 'Assets/Images/sands.png'),
      //       //
      //       popupMenuItemSpacer(),
      //       //
      //       popupMenuItemForTheme(label: 'Light', imagePath: 'Assets/Images/white.jpg'),
      //       //
      //       popupMenuItemSpacer(),
      //       //
      //       popupMenuItemForTheme(label: 'Dark', imagePath: 'Assets/Images/sands.png'),
      //       //
      //     ]);
    });
  }
}
