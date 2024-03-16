import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sessions/features/auth/_objects/variables.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_widgets/components/toast.dart';
import 'auth_error_handler.dart';

Future<void> signInUsingEmailPassword(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  try {
    hideKeyboard();

    // Validate the Sign In Form Input
    if (signInFormKey.currentState!.validate()) {
      showToast(2, 'Signing you in...');

      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      //
      // if user is not null, sign in was successful
      // we save user data locally and go to homepage
      if (user != null) {
        await updateUserDetailsLocal(user.uid, user.displayName ?? 'Professor X', email);
        context.go('/');
      }

      printThis('.......................... SIGN IN COMPLETE!');
    }
  } on FirebaseAuthException catch (error) {
    //
    showToast(0, handleFirebaseAuthError(error, process: 'sign in'));
  } catch (error) {
    //
    showToast(0, handleOtherErrors(error, process: 'sign in'));
  }
}
