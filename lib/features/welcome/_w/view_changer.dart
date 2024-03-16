import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/welcome/_helpers/helpers.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_providers/common_providers/views_provider.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/icons.dart';
import 'view_circle_indicator.dart';

class OnboardingViewChanger extends StatelessWidget {
  const OnboardingViewChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, viewsProvider, child) {
      bool isNotFirstPage = viewsProvider.selectedOnboardingView != 0;
      bool isNotLastPage = viewsProvider.selectedOnboardingView != 3;

      return Column(
        children: [
          //
          // Skip Button
          //
          if (isNotLastPage) SecondaryButton(label: 'Skip', onPressed: (() => skipToLastOnBoardingPage()), isAuth: true),
          //
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //
              // Previous Page Button
              //
              AppIconButton(
                Icons.keyboard_arrow_left_rounded,
                onPressed: isNotFirstPage ? () => goToPreviousOnBoardingPage() : null,
                color: isNotFirstPage ? styler.white : Colors.transparent,
              ),
              //
              // Circle Indicators
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(4, (pageIndex) => OnBoardingCircleIndicator(pageIndex: pageIndex)),
              ),
              //
              // Next Page Button
              //
              AppIconButton(
                Icons.keyboard_arrow_right_rounded,
                onPressed: isNotLastPage ? () => goToNextOnBoardingPage() : null,
                color: isNotLastPage ? styler.white : Colors.transparent,
              )
              //
              //
            ],
          ),
          //
          largeSpacerHeight(),
          //
        ],
      );
    });
  }
}
