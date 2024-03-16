import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../_helpers/_common_helpers/global_helper.dart';

class PinnedIndicator extends StatelessWidget {
  const PinnedIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Transform.rotate(
        angle: 0.3,
        child: Icon(Icons.push_pin_rounded, size: 18),
      ),
    );
  }
}

class NoWidget extends StatelessWidget {
  const NoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

class SelectorArrows extends StatelessWidget {
  const SelectorArrows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.keyboard_arrow_up_rounded,
          color: styler.textColor(),
          fill: 0,
          opticalSize: 1,
          weight: 1,
          grade: 1,
        ),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: styler.textColor(),
        ),
      ],
    );
  }
}

class ColorContainer extends StatelessWidget {
  const ColorContainer({Key? key, required this.bgColor, this.onTap}) : super(key: key);

  final String bgColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
      child: Container(
        height: 15,
        decoration: BoxDecoration(
          color: getItemColor(bgColor),
          borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
        ),
      ),
    );
  }
}
