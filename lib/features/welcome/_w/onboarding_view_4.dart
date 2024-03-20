import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_widgets/components/toast.dart';
import 'package:sessions/features/welcome/_w/intro_text.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_widgets/components/buttons.dart';

class OnboardingView4 extends StatelessWidget {
  const OnboardingView4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Spacer(),
        //
        //
        OnBoardingIntroText(),
        //
        semiLargeSpacerHeight(),
        //
        //
        ActionButton(
          color: styler.white,
          label: 'Continue with Google',
          imagePath: 'assets/images/google.png',
          // onPressed: () => signInWithGoogle(),
          onPressed: () => showToast(2, 'Service is currently unavailble. Please sign in with email.'),
        ),
        //
        //
        tinySpacerHeight(),
        tinySpacerHeight(),
        //
        //
        ActionButton(
          color: styler.white,
          label: 'Continue with Apple',
          imagePath: 'assets/images/apple.png',
          // onPressed: () => signInWithApple(),
          onPressed: () => showToast(2, 'Service is currently unavailble. Please sign in with email.'),
        ),
        //
        //
        tinySpacerHeight(),
        tinySpacerHeight(),
        //
        //
        ActionButton(
          color: styler.white,
          label: 'Continue with Email',
          imagePath: 'assets/images/email.png',
          onPressed: () => context.push('/emailauth'),
        ),
        //
        //
        tinySpacerHeight(),
        //
        // SecondaryButton(
        //   label: 'Skip',
        //   icon: Icons.arrow_forward_rounded,
        //   isEndIcon: true,
        //   onPressed: () => anonymousSignIn(),
        // ),
        //
        //
        Spacer(),
        //
        //
      ],
    );
  }
}
