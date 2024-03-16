import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sessions/_widgets/components/text_styles.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../_config/styling/styler.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({Key? key, required this.message, required this.child, this.axisDirection = AxisDirection.down}) : super(key: key);

  final String message;
  final Widget child;
  final AxisDirection axisDirection;

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      backgroundColor: styler.transparent,
      waitDuration: Duration(milliseconds: 500),
      content: message.isNotEmpty
          ? Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: styler.tooltipColor(),
                borderRadius: BorderRadius.circular(borderRadiusTiny),
              ),
              child: AppText(size: small, text: message, textColor: styler.invertedTextColor()),
            )
          : NoWidget(),
      preferredDirection: axisDirection,
      tailLength: 0,
      tailBaseWidth: 0,
      shadow: Shadow(blurRadius: 0, color: styler.transparent),
      child: child,
    );
  }
}
