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
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
      hoverColor: iconColor.withOpacity(0.2),
      splashColor: iconColor.withOpacity(0.2),
      highlightColor: iconColor.withOpacity(0.2),
      child: Container(
        padding: EdgeInsets.all(15),
        width: isPhone() ? 46.w : 30.w,
        constraints: BoxConstraints(minHeight: 150, maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.3)),
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
          ],
        ),
      ),
    );
  }
}
