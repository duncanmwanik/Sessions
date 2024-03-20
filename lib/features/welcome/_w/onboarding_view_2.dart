import 'package:flutter/material.dart';
import 'package:sessions/features/welcome/_w/view_container.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_widgets/components/images.dart';
import '../../../_widgets/components/text_styles.dart';

class OnboardingView2 extends StatelessWidget {
  const OnboardingView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      children: [
        //
        AppImage(imagePath: 'assets/images/team.png', size: imageSizeMedium),
        largeSpacerHeight(),
        AppText(size: textSizeOnBoarding, text: 'Share & Collaborate', textColor: styler.white),
        mediumSpacerHeight(),
        AppText(size: normal, text: 'Make the most of every day.', fontWeight: FontWeight.w400, textColor: styler.white),
        //
      ],
    );
  }
}
