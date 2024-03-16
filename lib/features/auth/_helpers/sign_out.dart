import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation_variables.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';

Future<void> signOutUser() async {
  await showConfirmationDialog(
    title: 'Are you sure you want to sign out?',
    yeslabel: 'Sign Out',
  ).then((agreed) async {
    if (agreed == true) {
      await FirebaseAuth.instance.signOut();
      globalBox.put('isFirstTimeUser', true);
      viewsProviderX.updateOnboardingView(0);
      homeX.currentContext!.go('/welcome');
    }
  });
}
