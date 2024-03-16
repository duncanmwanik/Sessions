import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/text_styles.dart';
import 'package:sessions/features/labels/_state/labels_provider.dart';

import '../../_config/styling/spacing.dart';
import '../../_widgets/components/icons.dart';
import 'bottom_sheet_labels.dart';

class LabelChooser extends StatelessWidget {
  const LabelChooser({super.key, this.extended = false});

  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Consumer<LabelsProvider>(builder: (context, labelsProvider, child) {
      return AppButton(
        onPressed: () async {
          await showLabelsBottomSheet().then((labelList) {
            if (labelList != null && labelList.isNotEmpty) {
              labelsProvider.updateSelectedLabel(labelList.first);
            }
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(size: medium, text: labelsProvider.selectedLabel)),
            smallSpacerWidth(),
            AppIcon(Icons.arrow_drop_down, size: normal),
          ],
        ),
      );
    });
  }
}
