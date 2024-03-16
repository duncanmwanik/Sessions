import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/dialogs/dialog_select_groups.dart';
import '../../_state/table_input_provider.dart';

class TableGroupSelector extends StatelessWidget {
  const TableGroupSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TableInputProvider>(builder: (context, inputProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          //
          //
          Row(
            children: [
              AppIcon(FontAwesomeIcons.folderPlus, faded: true),
              smallSpacerWidth(),
              AppButton(
                onPressed: () => showSelectTableGroupsDialog(),
                child: AppText(size: medium, text: 'Add to Group'),
              ),
            ],
          ),
          //
          //
          //
          if (inputProvider.selectedTableGroups.isNotEmpty && kIsWeb) smallSpacerHeight(),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 5),
            child: Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: List.generate(inputProvider.selectedTableGroups.length, (index) {
                String groupName = inputProvider.selectedTableGroups[index];

                return ElevatedButton(
                    onPressed: () => showSelectTableGroupsDialog(),
                    style: ElevatedButton.styleFrom(
                      padding: kIsWeb ? null : EdgeInsets.only(left: 15, top: 3, bottom: 3),
                      backgroundColor: styler.itemColor(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMediumSmall)),
                      side: BorderSide.none,
                      minimumSize: minSizeZero(),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.folder_outlined, tiny: true),
                        smallSpacerWidth(),
                        Flexible(child: AppText(size: medium, text: groupName, overflow: TextOverflow.visible)),
                        smallSpacerWidth(),
                        AppIconButton(
                          onPressed: () => inputProvider.updateSelectedTableGroups(groupName),
                          Icons.close_rounded,
                          tiny: true,
                          faded: true,
                        ),
                      ],
                    ));
              }),
            ),
          ),
          //
          //
          //
        ],
      );
    });
  }
}
