import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/images.dart';

import '../components/text_styles.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        largeSpacerHeight(),
        //
        //
        AppImage(imagePath: 'assets/images/trw.png', size: imageSizeMedium),
        //
        mediumSpacerHeight(),
        //
        Flexible(child: AppText(size: onBoarding, text: 'Sayari', faded: true)),
        //
        smallSpacerHeight(),
        //
        //
        AppText(size: small, text: 'Version : Neo', faded: true),
        //
        tinySpacerHeight(),
        //
        //
        AppText(size: small, text: 'Sayari Apps LLC', faded: true),
        //
        tinySpacerHeight(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            AppTextButton(onPressed: () {}, label: 'Terms', fontSize: small, faded: true, shrunk: true),
            //
            Container(width: 5, height: 5, decoration: BoxDecoration(shape: BoxShape.circle, color: styler.textColor())),
            //
            AppTextButton(onPressed: () {}, label: 'Privacy Policy', fontSize: small, faded: true, shrunk: true),
            //
          ],
        ),
        //
        largeSpacerHeight(),
        //
      ],
    );
  }
}
