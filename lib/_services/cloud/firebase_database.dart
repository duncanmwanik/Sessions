import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../_helpers/_common_helpers/global_helper.dart';
import '../../firebase_options.dart';

const String tablesPathCloud = 'tables';
const String usersPathCloud = 'users';

CloudData cloudService = CloudData();

class CloudData {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<void> writeData(String path, Map data) async {
    await ref.child(path).update(getJsonMap(data));
  }

  Future<void> deleteData(String path) async {
    await ref.child(path).remove();
  }

  Future<DataSnapshot> getData(String path) async {
    DataSnapshot snapshot = await ref.child(path).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAfter(String path, String start) async {
    DataSnapshot snapshot = await ref.child(path).orderByKey().startAfter(start).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAt(String path, String start) async {
    DataSnapshot snapshot = await ref.child(path).orderByKey().startAt(start).get();
    return snapshot;
  }

  Future<DataSnapshot> listenForDataOnValue(String path, String start) async {
    DataSnapshot snapshot = await ref.child(path).orderByKey().startAfter(start).get();
    return snapshot;
  }

  Future<Map> doesUserExist(String email) async {
    DataSnapshot snapshot = await ref.child(usersPathCloud).orderByChild('info/e').equalTo(email).get();
    if (snapshot.value != null) {
      return snapshot.value as Map;
    } else {
      return {};
    }
  }

  Future<void> closeConnection() async {
    await FirebaseDatabase.instance.goOffline();
  }

  Future<Map> getServerTimestamp() async {
    return ServerValue.timestamp;
  }
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
