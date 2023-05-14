import 'package:flutter/material.dart';

import '../../config/theme/theme_constants.dart';
import '../../helpers/firebase_auth/firebase_initialization.dart';
import '../../helpers/firebase_auth/firebase_signin_helper.dart';
import '../../variables/global_variables.dart';
import '../../helpers/form_validation/form_validation_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xff1f1f1f),
        body: FutureBuilder(
            future: initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.05),
                          child: Image.asset(
                            'assets/images/calendar.png',
                            height: w * 0.7,
                            width: w * 0.7,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: boxDecoration,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(hintText: "Email Address", hintStyle: hintStyle, border: InputBorder.none),
                            controller: emailController,
                            validator: (value) => Validator.validateEmail(email: value!),
                            onSaved: (String? val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: boxDecoration,
                          child: TextFormField(
                            obscureText: true,
                            onFieldSubmitted: null,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(hintText: "Password", hintStyle: hintStyle, border: InputBorder.none),
                            controller: passwordController,
                            validator: (value) => Validator.validatePassword(password: value!),
                            onSaved: (String? val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, top: 20, bottom: w * 0.1),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                              ),
                              child: const Text(
                                'Sign In',
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await signInUsingEmailPassword(
                                    context,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
