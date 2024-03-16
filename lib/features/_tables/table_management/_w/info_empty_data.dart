import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';

class EmptyTableData extends StatelessWidget {
  const EmptyTableData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        Image.asset(
          'assets/images/table.png',
          height: emptyImageHeight(),
          width: emptyImageHeight(),
        ),
        mediumSpacerHeight(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: AppText(size: medium, text: 'Tap ', faded: true)),
            AppIcon(FontAwesomeIcons.plus, size: textSizeMedium),
            Flexible(child: AppText(size: medium, text: ' to add a table', faded: true)),
          ],
        ),
        mediumSpacerHeight(),
      ],
    );
  }
}
