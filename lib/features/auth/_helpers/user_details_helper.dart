import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/theme_helper.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_services/hive/local_storage_service.dart';

Future<void> isFirstTimeUserOnApp() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    bool isFirstTimeUser = user == null ? true : false;
    globalBox.put('isFirstTimeUser', isFirstTimeUser);
    if (!isFirstTimeUser) {
      await Hive.openBox(getCurrentUserId());
    }
    changeStatusAndNavigationBarColor(getThemeType());
  } catch (_) {
    //
  }
}

bool isFirstTimeUser() {
  return globalBox.get('isFirstTimeUser', defaultValue: true);
}

void updateIsFirstTimeUser(bool value) {
  globalBox.put('isFirstTimeUser', value);
}
