import 'package:flutter/material.dart';

import '../../_services/hive/local_storage_service.dart';

class GlobalProvider with ChangeNotifier {
  // ---------- internet connection status
  bool isConnectedToInternet = false;

  void updateInternetConnectionStatus(bool status) {
    isConnectedToInternet = status;
  }

  // ---------- push notifications
  bool enablePushNotifications = false;

  void updatePushNotifications(bool enable) {
    enablePushNotifications = enable;
    notifyListeners();
  }

  // ---------- keeps table list in Table Mangement Screen Open
  bool keepTableListTileOpen = globalBox.get('keepTableListTileOpen', defaultValue: true);
  bool keepWebTablesTileOpen = globalBox.get('keepWebTablesTileOpen', defaultValue: true);
  bool keepWebLabelsTileOpen = globalBox.get('keepWebLabelsTileOpen', defaultValue: true);

  void changeKeepTableListTileOpen(String type, bool value) {
    if (type == 'TableList') {
      keepTableListTileOpen = value;
    } else if (type == 'WebTables') {
      keepWebTablesTileOpen = value;
    } else if (type == 'WebLabels') {
      keepWebLabelsTileOpen = value;
    }
    globalBox.put('keep${type}TileOpen', value);
    notifyListeners();
  }

  // ---------- keeps table list in Table Mangement Screen Open
  bool showWebBoxOptions = globalBox.get('showWebBoxOptions', defaultValue: true);

  void updateShowWebBoxOptions(bool value) {
    showWebBoxOptions = value;
    globalBox.put('showWebBoxOptions', value);
    notifyListeners();
  }

  // ---------- keeps track of whether the bottom sheet is open
  bool isBottomSheetOpen = false;

  void updateIsBottomSheetOpen(bool value) {
    isBottomSheetOpen = value;
    notifyListeners();
  }

  // ---------- keeps track of whether the bottom sheet is open
  bool isKeyboardOpen = false;

  void updateIsKeyboardOpenOpen(bool value) {
    isKeyboardOpen = value;
    notifyListeners();
  }
}
