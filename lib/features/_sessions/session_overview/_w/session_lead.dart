import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';

class SessionLead extends StatelessWidget {
  const SessionLead({super.key, required this.sessionLead});

  final String sessionLead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingSmall(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.person_rounded, tiny: true, color: styler.textColorFaded()),
                smallSpacerWidth(),
                Flexible(
                  child: AppText(size: medium, text: sessionLead, faded: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
