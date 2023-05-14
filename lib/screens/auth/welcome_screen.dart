import 'package:flutter/material.dart';

import '../../helpers/screen_size_helper.dart';
import '../../variables/global_variables.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'widgets/sign_in_up_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    getDeviceScreenDimensions(context);

    return Scaffold(
        backgroundColor: Color(0xff1f1f1f),
        body: ListView(
          shrinkWrap: true,
          children: [
            Image.asset(
              'assets/images/sessions.png',
              height: w * 0.7,
              width: w * 0.7,
            ),
            Text(
              "Sessions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            Padding(
              padding: EdgeInsets.only(top: h * 0.35, bottom: 20),
              child: Text(
                "...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white30),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                signInUpButton(
                  context: context,
                  label: "Sign In",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  ),
                ),
                signInUpButton(
                  context: context,
                  label: "Sign Up",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
