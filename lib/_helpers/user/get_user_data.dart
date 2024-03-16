import '../../_services/hive/local_storage_service.dart';

String getLocalUserDataVersion() {
  return userBox.get('version', defaultValue: '');
}
