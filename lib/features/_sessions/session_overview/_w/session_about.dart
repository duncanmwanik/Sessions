import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';

class SessionAbout extends StatelessWidget {
  const SessionAbout({super.key, required this.sessionAbout});

  final String? sessionAbout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingSmall(top: true, left: true, right: true),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          AppIcon(Icons.subject_rounded, tiny: true, faded: true),
          //
          //
          smallSpacerWidth(),
          //
          // Description Text
          //
          Flexible(
              child: AppText(
            size: medium,
            text: sessionAbout ?? '',
            fontWeight: FontWeight.w400,
            faded: true,
            overflow: TextOverflow.visible,
          )),
        ],
      ),
    );
  }
}
