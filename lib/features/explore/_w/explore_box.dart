import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../_widgets/components/text_styles.dart';

class ExploreBox extends StatelessWidget {
  const ExploreBox({Key? key, required this.title, required this.subtitle, required this.icon, this.iconColor = Colors.red, required this.onPressed}) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: styler.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
        hoverColor: styler.appColor(2),
        splashColor: styler.appColor(2),
        highlightColor: styler.appColor(2),
        child: Container(
          padding: EdgeInsets.all(15),
          width: isPhone() ? 46.w : 30.w,
          constraints: BoxConstraints(minHeight: 150, maxWidth: 300),
          decoration: BoxDecoration(
            color: styler.appColor(1),
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
            border: styler.itemBorder(false),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // Image
              //
              AppIcon(icon, size: 40, color: iconColor),
              //
              mediumSpacerHeight(),
              smallSpacerHeight(),
              //
              //
              // Title
              Flexible(child: AppText(size: normal, text: title)),
              //
              smallSpacerHeight(),
              //
              //
              // Description
              Flexible(child: AppText(size: small, text: subtitle, faded: true)),
              //
              //
            ],
          ),
        ),
      ),
    );
  }
}
