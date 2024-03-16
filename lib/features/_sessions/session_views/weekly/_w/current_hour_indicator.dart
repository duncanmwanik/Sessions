import 'package:flutter/material.dart';

import '../../../../../_config/styling/styler.dart';

class CurrentHourIndicator extends StatelessWidget {
  const CurrentHourIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Divider(height: 0, thickness: 1, color: styler.accentColor()),
        Container(
          width: 5,
          height: 2.5,
          decoration: BoxDecoration(
              color: styler.accentColor(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadiusLarge),
                bottomRight: Radius.circular(borderRadiusLarge),
              )),
        ),
      ],
    );
  }
}
