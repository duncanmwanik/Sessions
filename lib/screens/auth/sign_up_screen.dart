import 'package:flutter/material.dart';

import '../../config/theme/theme_constants.dart';
import '../../helpers/firebase_auth/firebase_initialization.dart';
import '../../variables/global_variables.dart';
import '../../../widgets/toast.dart';
import '../../helpers/firebase_auth/firebase_signup_helper.dart';
import '../../helpers/form_validation/form_validation_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? firstName, lastName, email, password, confirmPassword;

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
                            padding: EdgeInsets.only(top: h * 0.05, bottom: h * 0.05),
                            child: Image.asset(
                              'assets/images/datepicker.png',
                              height: h * 0.3,
                              width: h * 0.3,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: boxDecoration,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              validator: (value) => Validator.validateName(name: value!),
                              onSaved: (String? val) {
                                firstName = val;
                              },
                              controller: userNameController,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(height: 0.8, fontSize: 18.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(hintText: 'Username', hintStyle: hintStyle, border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: boxDecoration,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) => Validator.validateEmail(email: value!),
                              controller: emailController,
                              onSaved: (String? val) {
                                email = val;
                              },
                              style: const TextStyle(height: 0.8, fontSize: 18.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(hintText: 'Email', hintStyle: hintStyle, border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: boxDecoration,
                            child: TextFormField(
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              controller: passwordController,
                              validator: (value) => Validator.validatePassword(password: value!),
                              onSaved: (String? val) {
                                password = val;
                              },
                              style: const TextStyle(height: 0.8, fontSize: 18.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(hintText: 'Password', hintStyle: hintStyle, border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: boxDecoration,
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              controller: confirmPasswordController,
                              validator: (value) => Validator.validatePassword(password: value!),
                              onSaved: (String? val) {
                                confirmPassword = val;
                              },
                              style: const TextStyle(height: 0.8, fontSize: 18.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(hintText: 'Confirm Password', hintStyle: hintStyle, border: InputBorder.none),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, top: 20, bottom: w * 0.1),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                              ),
                              child: const Text(
                                'Sign Up',
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text == confirmPasswordController.text) {
                                    await signUpUsingEmailPassword(
                                      context,
                                      name: userNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  } else {
                                    toast(0, "Passwords need to match!");
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          // ListTile(
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
