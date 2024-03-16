import 'package:firebase_database/firebase_database.dart';

import '../../_helpers/user/user_info.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import 'firebase_database.dart';

Future<String> doesTableExist(String tableId) async {
  DataSnapshot snapshot = await cloudService.getData('$tablesPathCloud/$tableId/info/t');
  if (snapshot.value != null) {
    return snapshot.value as String;
  } else {
    return 'none';
  }
}

Future<Map> doesUserExist(String email) async {
  Map userMap = await cloudService.doesUserExist(email);
  return userMap;
}

Future<String> getUserEmailFromCloud(String userId) async {
  try {
    DataSnapshot userData = await cloudService.getData('$usersPathCloud/$userId/info/e');
    return userData.value as String;
  } catch (e) {
    return 'No email';
  }
}

Future<bool> isTableAdminCloud() async {
  String userId = getCurrentUserId();
  String tableId = currentSelectedTable();
  DataSnapshot snapshot = await cloudService.getData('$tablesPathCloud/$tableId/admins/$userId');
  return snapshot.exists;
}

Future<bool> isTableOwnerFirebase(String tableId, String userId) async {
  try {
    DataSnapshot snapshot = await cloudService.getData('$tablesPathCloud/$tableId/admins/$userId');
    return snapshot.value as String == '1';
  } catch (_) {
    return false;
  }
}

Future<bool> isAlreadyAdmin(String tableId, String userId) async {
  DataSnapshot snapshot = await cloudService.getData('$tablesPathCloud/$tableId/admins/$userId');
  return snapshot.exists;
}
