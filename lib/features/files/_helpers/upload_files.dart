import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

import '../../../_providers/_provider_variables.dart';
import '../../../_services/cloud/firebase_storage.dart';
import '../../../_services/hive/local_storage_service.dart';

Future<Map> getFilesToUpload({required String where}) async {
  Map fileMap = {};

  try {
    FilePickerResult? results = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (results != null) {
      List<PlatformFile> files = results.files;

      if (kIsWeb) {
        for (PlatformFile file in files) {
          if (file.bytes != null) {
            fileMap[file.name] = file.bytes;
          }
        }
      } else {
        for (PlatformFile file in files) {
          if (file.path != null) {
            fileMap[file.name] = file.path;
          }
        }
      }

      fileMap.forEach((filename, fileData) {
        String fileId = 'f${getUniqueId()}';

        if (where == 'tasks') {
          taskInputProviderX.addToTaskInputData(fileId, filename);
        }
        if (where == 'lists') {
          listInputProviderX.addToListInputData(fileId, filename);
        }
        if (where == 'listItems') {
          listItemInputProviderX.addToListItemData(fileId, filename);
        }
        if (where == 'sessions') {
          sessionInputProviderX.addToSessionInputData(fileId, filename);
        }
        fileBox.put(fileId, fileData);
      });
    }
  } catch (e) {
    errorPrint('get-files-to-upload', e);
  }

  // return {};
  return fileMap;
}

void handleFilesCloud(String tableId, Map source, {String? items}) {
  //
  // creating
  //
  if (items == null) {
    source.forEach((key, value) {
      try {
        if (key.toString().startsWith('f')) {
          if (fileBox.containsKey(key)) {
            cloudStorage.uploadFile(path: '$tableId/$value', fileId: key);
            if (kIsWeb) fileBox.delete(key);
          }
        }
      } catch (e) {
        errorPrint('upload-file-new-[$value]', e);
      }
    });
  }
  //
  // editing
  //
  else {
    getSplitList(items).forEach((item) {
      try {
        // add new file
        if (item.toString().startsWith('f')) {
          if (fileBox.containsKey(item)) {
            cloudStorage.uploadFile(path: '$tableId/${source[item]}', fileId: item);
            if (kIsWeb) fileBox.delete(item);
          }
        }
        // delete file
        if (item.toString().startsWith('d/f')) {
          String key = item.toString().substring(2);

          if (fileNamesBox.containsKey(key)) {
            cloudStorage.deleteFile('$tableId/${fileNamesBox.get(key)}');
            if (kIsWeb) fileBox.delete(item);
          }
        }
      } catch (e) {
        errorPrint('upload-file-edit-[$item]', e);
      }
    });
  }
}
