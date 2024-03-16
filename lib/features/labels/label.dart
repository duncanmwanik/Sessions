import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/helpers.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../_config/styling/styler.dart';

class Label extends StatelessWidget {
  const Label({Key? key, required this.label, this.bgColor, this.onPressed}) : super(key: key);

  final String label;
  final String? bgColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    bool hasBgColor = hasBGColor(bgColor);

    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        side: BorderSide.none,
        backgroundColor: styler.reminderOverviewColor(bgColor),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: kIsWeb ? 13 : 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
        minimumSize: minSizeZero(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: AppText(size: small, text: label, textColor: hasBgColor ? Colors.black87 : styler.textColor()),
    );
  }
}
