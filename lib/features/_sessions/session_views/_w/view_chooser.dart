import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/common_providers/views_provider.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';
import 'package:sessions/_widgets/menus/menu_item.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_variables/common_variables.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/components/tooltip.dart';

class ViewChooser extends StatelessWidget {
  const ViewChooser({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();

    return Consumer<ViewsProvider>(builder: (context, viewsProvider, child) {
      return AppTooltip(
        message: 'Change Calendar View',
        child: AppPopupMenu(
            //
            menukey: menuKey,
            //
            // Shows selected view on the Header
            // Opens menu when pressed
            //
            menuButton: AppButton(
              onPressed: () => openPopupMenu(menuKey),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // Selected View
                  //
                  Flexible(
                    child: AppText(size: medium, text: sessionViews[viewsProvider.selectedSessionView]),
                  ),
                  //
                  smallSpacerWidth(),
                  //
                  AppIcon(Icons.arrow_drop_down, size: 15),
                  //
                ],
              ),
            ),
            menuItems: [
              //
              // Daily View
              //
              popupMenuItem(
                label: 'Day',
                trailing: viewsProvider.selectedSessionView == 0 ? Icons.done_rounded : null,
                onTap: () async {
                  if (viewsProvider.selectedSessionView != 0) {
                    viewsProvider.updateSessionView(0);
                  }
                  //pops menu
                  popWhatsOnTop();
                },
              ),
              //
              // Weekly View
              //
              popupMenuItem(
                label: 'Week',
                trailing: viewsProvider.selectedSessionView == 1 ? Icons.done_rounded : null,
                onTap: () async {
                  if (viewsProvider.selectedSessionView != 1) {
                    viewsProvider.updateSessionView(1);
                  }
                  //pops menu
                  popWhatsOnTop();
                },
              ),
              //
              // Monthly View
              //
              popupMenuItem(
                label: 'Month',
                trailing: viewsProvider.selectedSessionView == 2 ? Icons.done_rounded : null,
                onTap: () async {
                  if (viewsProvider.selectedSessionView != 2) {
                    viewsProvider.updateSessionView(2);
                  }
                  //pops menu
                  popWhatsOnTop();
                },
              ),
              //
              // Monthly View
              //
              popupMenuItem(
                label: 'Year',
                trailing: viewsProvider.selectedSessionView == 3 ? Icons.done_rounded : null,
                onTap: () async {
                  if (viewsProvider.selectedSessionView != 3) {
                    viewsProvider.updateSessionView(3);
                  }
                  //pops menu
                  popWhatsOnTop();
                },
              ),
              //
              //
              //
            ]),
      );
    });
  }
}
