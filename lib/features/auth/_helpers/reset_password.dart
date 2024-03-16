import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/_common_helpers/internet_connection.dart';
import '../../../_widgets/components/toast.dart';
import 'auth_error_handler.dart';

Future<void> resetPassword({required String email}) async {
  showToast(2, 'Resetting password...');
  hasAccessToInternet().then((value) async {
    if (value) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
        showToast(1, 'Reset link sent. Check your email.');
      }).catchError((e) {
        errorPrint('reset_password', e);
        showToast(0, handleFirebaseAuthError(e, process: 'reset password'));
      });
    }
  });
}
