import '../../_services/hive/load_boxes.dart';
import '../../_services/hive/local_storage_service.dart';

Future<void> updateUserDetailsLocal(String userId, String name, String email) async {
  await globalBox.put('currentUserId', userId);
  //
  // we reload the boxes to initialize the user's boxes
  await loadAllHiveBoxes();
  //
  await userBox.put('name', name);
  await userBox.put('email', email);
}

String getCurrentUserId() {
  return globalBox.get('currentUserId', defaultValue: 'none');
}

String getCurrentUserEmail() {
  return userBox.get('email', defaultValue: '---');
}

String getCurrentUserName() {
  return userBox.get('name', defaultValue: '---');
}
