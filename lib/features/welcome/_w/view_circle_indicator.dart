import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/features/welcome/_helpers/helpers.dart';

import '../../../_providers/common_providers/views_provider.dart';

class OnBoardingCircleIndicator extends StatelessWidget {
  const OnBoardingCircleIndicator({Key? key, required this.pageIndex}) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, viewsProvider, child) {
      bool isCurrentOnBoardingPage = viewsProvider.selectedOnboardingView == pageIndex;

      return InkWell(
        onTap: () => goToSpecifiedOnBoardingPage(pageIndex),
        customBorder: CircleBorder(),
        child: Container(
          width: isCurrentOnBoardingPage ? 6 : 4,
          height: isCurrentOnBoardingPage ? 6 : 4,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isCurrentOnBoardingPage ? styler.white : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}
