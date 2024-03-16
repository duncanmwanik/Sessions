import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_providers/common_providers/theme_provider.dart';
import '../../../_widgets/components/list_tile.dart';
import '../../../_widgets/components/text_styles.dart';
import 'list_tile_widgets.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Column(
        children: [
          SettingTitle('THEME'),
          AppListTile(
            leading: AppText(size: medium, text: 'Dark'),
            trailing: Visibility(visible: themeProvider.isDarkTheme == 'dark', child: Icon(Icons.done_rounded)),
            onTap: () => themeProvider.enableDarkTheme('dark'),
          ),
          divider(),
          AppListTile(
            leading: AppText(size: medium, text: 'Light'),
            trailing: Visibility(visible: themeProvider.isDarkTheme == 'light', child: Icon(Icons.done_rounded)),
            onTap: () => themeProvider.enableDarkTheme('light'),
          ),
          divider(),
          AppListTile(
            leading: AppText(size: medium, text: 'Follow system theme'),
            trailing: Visibility(visible: themeProvider.isDarkTheme == 'system', child: Icon(Icons.done_rounded)),
            onTap: () => themeProvider.enableDarkTheme('system'),
          ),
        ],
      );
    });
  }
}
