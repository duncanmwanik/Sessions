import '../../_services/cloud/firebase_database.dart';

Future<void> setupUserInCloud(String userId, String name, String email) async {
  await cloudService.writeData('$usersPathCloud/$userId', {
    'info': {'n': name, 'e': email}
  });
}
