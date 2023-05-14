// all other helper methods

import 'package:flutter/material.dart';
import 'package:sessions/services/local_storage_service.dart';

// --------------------------------- Debugging Helpers ---------------------------------
void errorPrint(String where, var e) {
  print("!!! ERROR :: $where >> [  $e  ]");
}

void setIsFirstTimeUserToFalse() async {
  // set first time running the app to false
  localStorage.setBool("isFirstTimeUser", false);
}

void removeLoadingCircle(BuildContext context) {
  Navigator.pop(context);
}
