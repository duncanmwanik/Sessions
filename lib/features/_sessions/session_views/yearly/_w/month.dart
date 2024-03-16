import 'package:flutter/material.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_variables/common_variables.dart';
import '../../../../../_widgets/components/text_styles.dart';

class SessionWidgetMonthly extends StatelessWidget {
  const SessionWidgetMonthly({super.key, required this.sessionData});

  final Map sessionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: itemMarginMonthly(left: true, right: true),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusSuperTiny),
        color: sessionColorList[int.parse(sessionData['c'] ?? 3)].color,
      ),
      child: AppText(
        size: small,
        text: sessionData['t'],
        overflow: TextOverflow.clip,
        textColor: sessionColorList[int.parse(sessionData['c'] ?? 3)].textColor,
        maxlines: 1,
      ),
    );
  }
}
