import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_widgets/components/text_styles.dart';

class SessionInfoTile extends StatelessWidget {
  const SessionInfoTile({super.key, required this.leadingText, required this.trailingText});

  final String leadingText;
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(size: medium, text: leadingText, faded: true),
            SizedBox(width: smallWidth()),
            AppText(size: medium, text: trailingText, faded: true),
          ],
        ),
      ],
    );
  }
}
