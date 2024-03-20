import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_config/styling/styler.dart';
import '../../_providers/_provider_variables.dart';
import '../../_variables/common_variables.dart';
import '../../_variables/global_variables.dart';
import '../../_variables/navigation_variables.dart';
import '../../_widgets/components/snackbar.dart';
import '../../_widgets/components/toast.dart';
import '../../features/auth/_helpers/user_details_helper.dart';
import '../user/user_info.dart';

void errorPrint(String where, var e) {
  if (kDebugMode) {
    debugPrint('APP-ERROR: ($where) ^ $e ^');
  }
}

void printThis(var stuff) {
  if (kDebugMode) {
    log(stuff.toString());
  }
}

void hideKeyboard() {
  try {
    FocusManager.instance.primaryFocus?.unfocus();
  } catch (_) {}
}

void removeFocus() {
  try {
    FocusScope.of(homeX.currentContext!).requestFocus(FocusNode());
  } catch (_) {}
}

Map<String, dynamic> getJsonMap(Map data) {
  return Map<String, dynamic>.from(data);
}

String capitalizeStackTrace(String phrase) {
  return phrase.split('-').map((element) => '${element[0].toUpperCase()}${element.substring(1).toLowerCase()}').join(' ');
}

void doSomeFirstTimeWork() {
  if (isFirstTimeUser()) {
    try {
      showToast(1, 'Hello ${getCurrentUserName()}! Welcome...', duration: 6);
      updateIsFirstTimeUser(false);
    } catch (e) {
      showToast(1, 'Welcome human...');
    }
  }
}

Map getNewMapFrom(Map map) {
  return json.decode(json.encode(map));
}

List<String> getSplitList(String? string, {String separator = '|'}) {
  try {
    if (string != null) {
      return string.split(separator).where((e) => e.isNotEmpty).toList();
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

String getJoinedList(List list) {
  try {
    if (list.isNotEmpty) {
      return list.join('|');
    } else {
      return '';
    }
  } catch (e) {
    return '';
  }
}

void popWhatsOnTop({dynamic value}) {
  if (homeX.currentContext!.canPop()) {
    homeX.currentContext!.pop(value);
  }
}

void closeAllSnackBars() {
  ScaffoldMessenger.of(homeX.currentContext!).clearSnackBars();
}

void closeBottomSheetIfOpen() {
  if (globalProviderX.isBottomSheetOpen) {
    popWhatsOnTop();
    globalProviderX.updateIsBottomSheetOpen(false);
  }
}

void popCurrentScreen({dynamic value, bool isWelcome = false}) {
  if (isWelcome) {
    if (welcomeX.currentContext!.canPop()) {
      welcomeX.currentContext!.pop(value);
    }
  } else {
    if (homeX.currentContext!.canPop()) {
      homeX.currentContext!.pop(value);
    }
  }
}

void closeDrawerIfOpened() {
  if (homeX.currentState?.isDrawerOpen == true) {
    homeX.currentState?.closeDrawer();
  }
}

void openDrawer() {
  homeX.currentState!.openDrawer();
}

bool isDrawerOpened() {
  return homeX.currentState?.isDrawerOpen == true;
}

void openPopupMenu(GlobalKey menuKey) {
  try {
    dynamic state = menuKey.currentState;
    state.showButtonMenu();
  } catch (_) {}
}

bool confirmExitApp() {
  if (isDrawerOpened()) {
    closeDrawerIfOpened();
    return false;
  } else {
    if (exitApp) {
      return true;
    } else {
      exitApp = true;
      showSnackBar('Tap again to exit...');
      Future.delayed(Duration(seconds: 5), () {
        exitApp = false;
      });
      return false;
    }
  }
}

bool isImageTheme() {
  return !['dark', 'light'].contains(themeProviderX.themeImage);
}

Color? getItemColor(String? colorNo, {bool? isHovered}) {
  try {
    if (colorNo != null && colorNo != 'x' && colorNo != '') {
      return itemBgColors[colorNo] ?? styler.itemColor();
    } else {
      return styler.secondaryColor();
      // if (isHovered == true) {
      //   return styler.secondaryColor();
      // } else {
      //   return styler.secondaryColor();
      // }
    }
  } catch (e) {
    return styler.primaryColor();
  }
}

bool hasItemColor(String? colorNo) {
  if (colorNo != null && colorNo.isNotEmpty && colorNo != 'x') {
    return true;
  } else {
    return false;
  }
}

bool hasFlagList(String? flagList) {
  if (flagList != null && flagList.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

String getUniqueId() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}

String getUniqueIdMs() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

Color getSheetColor(String colorNo) {
  try {
    if (colorNo == 'x') {
      return styler.primaryColor();
    } else {
      return itemBgColors[colorNo] ?? styler.tertiaryColor();
    }
  } catch (e) {
    return styler.primaryColor();
  }
}

bool hasReminder(String? reminder) {
  if (reminder != null && reminder.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

void clearItemSelection() {
  itemSelectionProviderX.clearAnyItemSelections();
}

Map getFilesOnlyMap(Map source, {String? items}) {
  Map filesOnlyMap = {};
  filesOnlyMap = getNewMapFrom(source);

  source.forEach((key, value) {
    if (!key.toString().startsWith('f')) {
      filesOnlyMap.remove(key);
    }
  });

  return filesOnlyMap;
}

String getfileExtension(String fileName) {
  try {
    return fileName.split('.').last;
  } catch (e) {
    return 'FILE';
  }
}

String getfileNameOnly(String fileName) {
  try {
    return fileName.split('.')[0];
  } catch (e) {
    return 'FILE';
  }
}
