import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/loading_circle.dart';
import '../../../widgets/toast.dart';
import '../../screens/home/home_screen.dart';
import '../global_helper.dart';

Future<void> signInUsingEmailPassword(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  try {
    showLoadingCircle(context);

    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      removeLoadingCircle(context);
      toast(1, "Sign In successful.");
      setIsFirstTimeUserToFalse();

      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const HomeScreen(),
        ),
        (route) => false,
      );
    }
  } on FirebaseAuthException catch (e) {
    removeLoadingCircle(context);

    if (e.code == 'user-not-found') {
      toast(0, 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      toast(0, 'Wrong password.');
    } else if (e.code == 'invalid-email') {
      toast(0, 'Email is invalid.');
    } else if (e.code == 'user-disabled') {
      toast(0, 'Account has been disabled.');
    }
  } catch (e) {
    removeLoadingCircle(context);
    print(e);
  }
}
