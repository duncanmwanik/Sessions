import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/loading_circle.dart';
import '../../../widgets/toast.dart';
import '../../screens/home/home_screen.dart';
import '../global_helper.dart';

Future<void> signUpUsingEmailPassword(
  BuildContext context, {
  required String name,
  required String email,
  required String password,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    showLoadingCircle(context);

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    await user!.updateDisplayName(name);
    await user.reload();
    user = auth.currentUser;

    if (user != null) {
      removeLoadingCircle(context);
      toast(1, "Sign Up successful.");
      setIsFirstTimeUserToFalse();

      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false,
      );
    }
  } on FirebaseAuthException catch (e) {
    removeLoadingCircle(context);

    if (e.code == 'weak-password') {
      toast(0, 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      toast(2, 'An account already exists for that email. Please sign in.');
    } else if (e.code == 'invalid-email') {
      toast(0, 'Email is invalid.');
    } else if (e.code == 'operation-not-allowed') {
      toast(0, 'Operation invalid..');
    }
  } catch (e) {
    removeLoadingCircle(context);
    print(e);
  }
}
