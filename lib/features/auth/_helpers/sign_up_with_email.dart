import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sessions/features/_tables/_helpers/create_table.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/user/create_new_user.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_widgets/components/toast.dart';
import '../_objects/variables.dart';
import 'auth_error_handler.dart';

Future<void> signUpUsingEmailPassword(
  BuildContext context, {
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  try {
    hideKeyboard();
    // Validate the Sign Up Form Input
    if (signUpFormKey.currentState!.validate()) {
      // Check for password equality
      if (password == confirmPassword) {
        showToast(1, 'Signing you up...');

        FirebaseAuth auth = FirebaseAuth.instance;
        User? user;
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        user = userCredential.user;
        await user!.updateDisplayName(name);
        await user.reload();
        user = auth.currentUser;
        //
        //
        if (user != null) {
          // we save user data in the cloud
          await setupUserInCloud(user.uid, name, email);
          // we save user data locally
          await updateUserDetailsLocal(user.uid, name, email);
          // we create the user's complimentary free table
          await createNewTable({'t': 'My Table'}, newUserId: user.uid);
          // we go to homepage
          context.go('/');
        }

        printThis('.......................... SIGN UP COMPLETE!');
      } else {
        showToast(0, 'Passwords should match');
      }
    }
  } on FirebaseAuthException catch (error) {
    //
    showToast(0, handleFirebaseAuthError(error, process: 'sign up'));
  } catch (error) {
    //
    showToast(0, handleOtherErrors(error, process: 'sign up'));
  }
}
