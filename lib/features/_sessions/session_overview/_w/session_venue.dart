import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';

class SessionVenue extends StatelessWidget {
  const SessionVenue({super.key, required this.sessionVenue});

  final String sessionVenue;

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
                AppIcon(Icons.location_on, tiny: true, color: styler.textColorFaded()),
                smallSpacerWidth(),
                Flexible(
                  child: AppText(size: medium, text: sessionVenue, faded: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
