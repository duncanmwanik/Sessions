import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../_config/styling/spacing.dart';
import '../../_widgets/components/buttons.dart';
import '../../_widgets/components/text_styles.dart';
import '../../_widgets/forms/email.dart';
import '../../_widgets/forms/password.dart';
import '_helpers/sign_in_with_email.dart';
import '_objects/variables.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController(text: 'duncan@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '1234567');
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signInFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          // Email Input
          EmailFormInput('Email Address', emailController),
          //
          kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
          //
          // Password Input
          PasswordFormInput('Password', passwordController, true),
          //
          isPhone() ? tinySpacerHeight() : smallSpacerHeight(),
          //
          // Forgot Pasword Button
          //
          SecondaryButton(
            label: 'Forgot password?',
            isAuth: true,
            onPressed: isSigningIn ? null : () => authProviderX.updateSelectedAuthView(2),
          ),
          //
          isPhone() ? tinySpacerHeight() : smallSpacerHeight(),
          //
          // Sign In Button
          //
          ActionButton(
            label: 'Sign In',
            showLoading: isSigningIn,
            onPressed: () async {
              //
              // We don't allow second presses when sign in is currently in progress
              // that's why we set IsSigningIn to true
              if (!isSigningIn) {
                setState(() => isSigningIn = true);

                // await is important, it ensures we see a progress indicator while signing in is in progress
                await signInUsingEmailPassword(context, email: emailController.text, password: passwordController.text);

                setState(() => isSigningIn = false);
              }
              //
            },
          ),
          //
          //
          smallSpacerHeight(),
          AppText(text: 'Or', size: medium, textColor: styler.white),
          smallSpacerHeight(),
          //
          //
          //
          ActionButton(
            label: 'Create Account',
            iconData: Icons.person_add_rounded,
            onPressed: isSigningIn ? null : () => authProviderX.updateSelectedAuthView(1),
          ),
          //
          //
        ],
      ),
    );
  }
}
