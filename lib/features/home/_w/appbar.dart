import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/layout_btn.dart';

import '../../../_config/styling/styler.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/others/other_widgets.dart';
import '../../../_widgets/others/quick_theme_changer.dart';
import '../../../_widgets/others/sync_indicator.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../_tables/table_overview/overview_sheet.dart';
import 'others.dart';

AppBar? homeAppBar() {
  return kIsWeb
      ? null
      : AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: NoWidget(),
          leadingWidth: 0,
          title: AppBarHome(),
        );
}

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(),
        builder: (context, box, widget) {
          String tableId = currentSelectedTable();
          bool isATableSelected = tableId != 'none';

          return Padding(
            padding: itemPadding(),
            child: ListTile(
              dense: true,
              horizontalTitleGap: 0,
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              tileColor: styler.appbarColor(),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
              //
              // Leading Drawer Icon Button
              //
              leading: AppIconButton(
                onPressed: () => openDrawer(),
                Icons.sort_rounded,
                largeSize: true,
              ),
              //
              // Selected Table Name
              //
              title: Row(
                children: [
                  //
                  //
                  InkWell(
                    onTap: () => openDrawer(),
                    borderRadius: BorderRadius.circular(borderRadiusMedium),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: AppText(
                        size: appBar,
                        text: isATableSelected ? tableNamesBox.get(tableId, defaultValue: 'Select a table') : 'Select a table',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  //
                  //
                  if (isATableSelected)
                    AppButton(
                      onPressed: () => showTableOverviewBottomSheet(),
                      noStyling: true,
                      child: AppIcon(Icons.more_horiz_rounded, faded: true),
                    ),
                  //
                ],
              ),
              //
              //
              // Actions
              //
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  mediumSpacerWidth(),
                  //
                  // AppText(text: 100.w.toString()),
                  //
                  //
                  CloudSyncIndicator(),
                  //
                  //
                  LayoutButton(),
                  //
                  //
                  QuickThemeChanger(),
                  //
                  // User Account + Settings Button
                  //
                  UserProfileButton(),
                  //
                  //
                  //
                ],
              ),
              //
              //
            ),
          );
        });
  }
}
