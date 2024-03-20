import 'package:flutter/material.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../_config/styling/helpers.dart';
import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';

class CheckBoxOverview extends StatelessWidget {
  const CheckBoxOverview({Key? key, required this.isChecked, this.isTiny = false, this.faded = false, this.noColor = false, this.bgColor, this.onTap}) : super(key: key);

  final bool isChecked;
  final bool isTiny;
  final bool faded;
  final bool noColor;
  final String? bgColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isColorInverted = hasBGColor(bgColor);

    return ElevatedButton(
      onPressed: onTap ?? () {},
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.zero,
        backgroundColor: styler.transparent,
        minimumSize: minSizeZero(),
        fixedSize: isTiny ? Size(15, 15) : Size(30, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        width: isTiny ? 14 : 16,
        height: isTiny ? 14 : 16,
        decoration: BoxDecoration(
          color: isChecked
              ? noColor
                  ? null
                  : styler.accentColor()
              : null,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isChecked
                ? noColor
                    ? styler.textColorFaded(inverted: isColorInverted)
                    : styler.transparent
                : styler.textColorFaded(inverted: isColorInverted),
            width: 1.7,
          ),
        ),
        child: Center(
          child: isChecked
              ? Icon(
                  Icons.done_rounded,
                  weight: 20,
                  size: isTiny ? 10 : 12,
                  color: isChecked
                      ? noColor
                          ? styler.textColor(inverted: isColorInverted)
                          : styler.white
                      : styler.textColor(inverted: isColorInverted),
                )
              : NoWidget(),
        ),
      ),
    );
  }
}
