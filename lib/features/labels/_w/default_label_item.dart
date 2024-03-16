import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/text_styles.dart';

class DefaultLabelItem extends StatelessWidget {
  const DefaultLabelItem({Key? key, required this.label, required this.iconData, this.isSelected = false, this.isPopable = false}) : super(key: key);

  final String label;
  final IconData iconData;
  final bool isSelected;
  final bool isPopable;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        labelsProviderX.updateSelectedLabel(label);
        //
        // if is from drawer or bottomsheet, we pop it
        if (isPopable) {
          popWhatsOnTop();
        }
      },
      dense: true,
      horizontalTitleGap: kIsWeb ? 1 : 0,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
      leading: AppIcon(iconData, tiny: true, color: isSelected ? styler.accentColor() : styler.textColorFaded()),
      title: AppText(size: medium, text: label),
    );
  }
}
