import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sessions/services/local_storage_service.dart';

class GlobalProvider with ChangeNotifier {
  // ---------- bottom nav bar
  int selectedTab = 0;

  void updateSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  // ---------- pageview
  int selectedPageView = localStorage.getInt("lastPageView") ?? 0;

  void updateSelectedPageView(int selected) {
    selectedPageView = selected;
    notifyListeners();
  }

  // ---------- user details
  String userName = "---";
  String userEmail = "---";

  void getUserDetails() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user.email);
      print(user.displayName);
      userName = user.displayName ?? "---";
      userEmail = user.email ?? "---";
      notifyListeners();
    }
  }

  // ---------- push notifications
  bool enablePushNotifications = false;

  void updatePushNotifications(bool enable) {
    enablePushNotifications = enable;
    notifyListeners();
  }
}
