// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

// import 'package:sessions/_services/hive/local_storage_service.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';

void downloadFileOnWeb(String fileId, String url) {
  try {
    // AnchorElement anchorElement = AnchorElement(href: url);
    // anchorElement.download = '';
    // anchorElement.click();
    // fileBox.put(fileId, 'downloaded');
  } catch (e) {
    errorPrint('download-file-web', e);
  }
}
