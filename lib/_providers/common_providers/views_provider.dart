import 'package:flutter/material.dart';

import '../../_services/hive/local_storage_service.dart';

class ViewsProvider with ChangeNotifier {
  // ---------- tabbar view for Home
  int selectedHomeView = globalBox.get('lastHomeView', defaultValue: 0);

  void updateHomeView(int index) {
    selectedHomeView = index;
    notifyListeners();
  }

  // ---------- pageview for Sesssion calendar view
  int selectedSessionView = globalBox.get('lastSessionView', defaultValue: 0);

  void updateSessionView(int index) {
    selectedSessionView = index;
    globalBox.put('lastSessionView', index);
    notifyListeners();
  }

  // ---------- pageview for Onboarding
  int selectedOnboardingView = 0;

  void updateOnboardingView(int index) {
    selectedOnboardingView = index;
    notifyListeners();
  }
}
