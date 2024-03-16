import '../../_services/hive/local_storage_service.dart';

void showOnUpdateLoader(bool show) {
  globalBox.put('showUpdateLoader', show);
}
