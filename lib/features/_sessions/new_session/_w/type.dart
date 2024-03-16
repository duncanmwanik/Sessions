import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_variables/common_variables.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../_state/session_input_provider.dart';
import '_w/type_item.dart';

class NewSessionTypePicker extends StatelessWidget {
  const NewSessionTypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(builder: (context, inputProvider, child) {
      final GlobalKey menuKey = GlobalKey();

      return AppPopupMenu(
        tooltip: 'Type',
        menukey: menuKey,
        menuButton: AppButton(
          onPressed: () => openPopupMenu(menuKey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: AppText(size: medium, text: sessionTypeList[int.parse(inputProvider.sessionInputData['y'])])),
              mediumSpacerWidth(),
              AppIcon(Icons.arrow_drop_down),
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
                children: List.generate(sessionTypeList.length, (index) {
                  return SessionTypeItem(
                      index: index,
                      onPressed: () {
                        print(index);
                        inputProvider.addToSessionInputData('y', index.toString());
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
