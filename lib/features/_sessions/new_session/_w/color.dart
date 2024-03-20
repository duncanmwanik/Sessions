import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_variables/common_variables.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/menus/app_popup_menu.dart';
import '../../_state/session_input_provider.dart';
import '_w/color_item.dart';

class NewSessionColorPicker extends StatelessWidget {
  const NewSessionColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();

    return Consumer<SessionInputProvider>(builder: (context, input, child) {
      return AppPopupMenu(
        tooltip: 'Color',
        menukey: menuKey,
        menuButton: AppButton(
          onPressed: () => openPopupMenu(menuKey),
          smallLeftPadding: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Container(
                height: 16,
                width: 46,
                decoration: BoxDecoration(
                  color: sessionColorList[int.parse(input.sessionInputData['c'])].color,
                  borderRadius: BorderRadius.circular(borderRadiusMedium),
                ),
              ),
              //
              mediumSpacerWidth(),
              //
              AppIcon(Icons.arrow_drop_down, size: 16),
              //
            ],
          ),
        ),
        menuItems: [
          PopupMenuItem(
            enabled: false,
            child: Center(
              child: Wrap(
                spacing: smallWidth(),
                runSpacing: smallWidth(),
                children: List.generate(sessionColorList.length, (index) {
                  return SessionColorItem(
                      index: index,
                      onPressed: () async {
                        input.addToSessionInputData('c', index.toString());
                        // pop menu
                        popWhatsOnTop();
                      });
                }),
              ),
            ),
          ),
        ],
      );
    });
  }
}
