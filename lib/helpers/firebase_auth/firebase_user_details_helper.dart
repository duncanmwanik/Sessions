import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../services/local_storage_service.dart';

Future<bool> getUserStatusFromFirebaseAuth() async {
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  bool isFirstTimeUser = false;

  if (user == null) {
    // print("User is not signed in!");
    isFirstTimeUser = localStorage.getBool("isFirstTimeUser") ?? true;
  } else {
    // print(user.email);
    // print(user.displayName);
  }

  return isFirstTimeUser;
}
