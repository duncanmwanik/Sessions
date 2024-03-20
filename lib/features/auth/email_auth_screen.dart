import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/features/auth/_state/auth_input_provider.dart';
import 'package:sessions/features/auth/reset_password.dart';
import 'package:sessions/features/auth/sign_in.dart';
import 'package:sessions/features/auth/sign_up.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/theme_helper.dart';
import '../../_widgets/components/buttons.dart';
import '../../_widgets/components/images.dart';
import '../../_widgets/components/text_styles.dart';

class EmailAuthScreen extends StatelessWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getDefaultThemeImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: styler.transparent,
        body: Consumer<AuthInputProvider>(builder: (context, authProvider, child) {
          int view = authProvider.selectedAuthView;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  //
                  AppImage(imagePath: 'assets/images/trw.png', size: imageSizeSmall),
                  //
                  smallSpacerHeight(),
                  //
                  AppText(size: 25, text: 'Sayari', fontWeight: FontWeight.w900, textColor: styler.white),
                  //
                  smallSpacerHeight(),
                  //
                  //
                  Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: isPhone() ? 5 : 30, vertical: 30),
                    decoration: BoxDecoration(
                      color: styler.appColor(3),
                      borderRadius: BorderRadius.circular(borderRadiusMedium),
                    ),
                    child: view == 0
                        ? SignInScreen()
                        : view == 1
                            ? SignUpScreen()
                            : ForgotPasswordScreen(),
                  ),
                  //
                  //
                  mediumSpacerHeight(),
                  //
                  // Goes back to Sign In Options
                  //
                  SecondaryButton(
                    label: 'Back',
                    icon: Icons.arrow_back_rounded,
                    isAuth: true,
                    onPressed: () => view == 0 ? popCurrentScreen(isWelcome: true) : authProvider.updateSelectedAuthView(0),
                  ),
                  //
                  //
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
