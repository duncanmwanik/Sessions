import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/others/scroll.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/theme_helper.dart';
import '../../_providers/_provider_variables.dart';
import '../../_variables/navigation_variables.dart';
import '_variables/variables.dart';
import '_w/onboarding_view_1.dart';
import '_w/onboarding_view_2.dart';
import '_w/onboarding_view_3.dart';
import '_w/onboarding_view_4.dart';
import '_w/view_changer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: AppScrollBehavior(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getDefaultThemeImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: styler.transparent,
          key: welcomeX,
          body: Center(
            child: Container(
              constraints: webMaxConstraints(),
              child: Column(
                children: [
                  //
                  // OnBoarding Pages
                  //
                  Expanded(
                    child: PageView(
                      scrollBehavior: AppScrollBehavior().copyWith(overscroll: false, scrollbars: false),
                      controller: onBoadingPageViewcontroller,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        viewsProviderX.updateOnboardingView(value);
                      },
                      children: [
                        OnboardingView1(),
                        OnboardingView2(),
                        OnboardingView3(),
                        OnboardingView4(),
                      ],
                    ),
                  ),
                  //
                  // OnBoarding page Change Buttons and Circle Indicators
                  //
                  OnboardingViewChanger(),
                  //
                  //
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
