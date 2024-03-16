import 'package:flutter/material.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_widgets/components/buttons.dart';
import '../../_widgets/components/text_styles.dart';
import '../../_widgets/forms/email.dart';
import '_helpers/reset_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _ForgotPasswordScreen();
  }
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          AppText(size: medium, text: 'A password reset link will be sent to your email.', textAlign: TextAlign.center, faded: true),
          //
          //
          mediumSpacerHeight(),
          //
          //
          EmailFormInput('Email Address', emailController),
          //
          //
          mediumSpacerHeight(),
          //
          //
          ActionButton(
            label: 'Reset',
            onPressed: () async {
              hideKeyboard();
              if (formKey.currentState!.validate()) {
                await resetPassword(email: emailController.text.trim());
              }
            },
          ),
          //
          //
        ],
      ),
    );
  }
}
