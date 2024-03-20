import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/features/auth/_objects/variables.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_widgets/components/buttons.dart';
import '../../_widgets/forms/email.dart';
import '../../_widgets/forms/password.dart';
import '../../_widgets/forms/text.dart';
import '_helpers/sign_up_with_email.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          TextFormInput('Name', userNameController),
          //
          kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
          //
          EmailFormInput('Email', emailController),
          //
          kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
          //
          PasswordFormInput('Password', passwordController, false),
          //
          kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
          //
          PasswordFormInput('Confirm Password', confirmPasswordController, true),
          //
          kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
          kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
          //
          // Sign Up Button
          //
          ActionButton(
              color: styler.white,
              label: 'Create Account',
              showLoading: isSigningUp,
              onPressed: () async {
                //
                // We don't allow second presses when sign up is currently in progress
                // that's why we set IsSigningUp to true
                if (!isSigningUp) {
                  setState(() => isSigningUp = true);
                  hideKeyboard();

                  // await is important, it ensures we see a progress indicator while signing up is in progress
                  await signUpUsingEmailPassword(
                    context,
                    name: userNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    confirmPassword: confirmPasswordController.text,
                  );

                  setState(() => isSigningUp = false);
                }
                //
              }),
          //
          //
          //
        ],
      ),
    );
  }
}
