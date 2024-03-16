import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_widgets/components/images.dart';
import '../../../_widgets/components/text_styles.dart';

class OnBoardingIntroText extends StatelessWidget {
  const OnBoardingIntroText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        AppImage(imagePath: 'assets/images/trw.png', size: imageSizeMedium),
        //
        mediumSpacerHeight(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: AppText(size: normal, text: 'A whole new world... ', textColor: styler.white)),
            smallSpacerWidth(),
            AppImage(imagePath: 'assets/images/wave.png', size: imageSizeTiny),
          ],
        ),
        //
        smallSpacerHeight(),
        //
      ],
    );
  }
}
