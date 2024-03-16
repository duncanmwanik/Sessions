import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_config/styling/spacing.dart';
import '../../../_providers/common_providers/item_selection_provider.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../labels/label_chooser.dart';
import 'dialog_create_list.dart';

class ListActions extends StatelessWidget {
  const ListActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      return Visibility(
        visible: selectionProvider.selectedItemMap.isEmpty,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: itemPadding(left: true, right: true),
            child: Row(
              children: [
                //
                // Label Chooser
                //
                if (!showWebBox()) LabelChooser(extended: true),
                //
                if (!showWebBox()) smallSpacerWidth(),
                //
                // Create List Button
                //
                if (!showWebBox())
                  AppButton(
                    onPressed: () => showCreateListDialog(),
                    child: Row(
                      children: [
                        AppIcon(Icons.add_rounded, size: 18),
                        tinySpacerWidth(),
                        AppText(size: medium, text: 'Create List'),
                      ],
                    ),
                  ),
                //
                //
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
