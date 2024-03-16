import 'package:flutter/material.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_variables/common_variables.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/text_styles.dart';

class SessionType extends StatelessWidget {
  const SessionType({super.key, required this.sessionType, required this.sessionColor});

  final String sessionType;
  final String sessionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        //
        // Session Type
        //
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: sessionColorList[int.parse(sessionColor)].color,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: AppText(
            size: medium,
            text: sessionTypeList[int.parse(sessionType)],
            fontWeight: FontWeight.w700,
            textColor: sessionColorList[int.parse(sessionColor)].textColor,
          ),
        ),

        //
        // Close button
        //
        CustomCloseButton(isX: true),
      ],
    );
  }
}
