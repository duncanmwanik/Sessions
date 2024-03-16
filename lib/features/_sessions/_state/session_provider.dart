import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  Map selectedSession = {};
  String selectedSessionId = 'none';

  void updateSelectedSession(Map newSession, String newSessionId) {
    selectedSession = newSession;
    selectedSessionId = newSessionId;
    notifyListeners();
  }
}
