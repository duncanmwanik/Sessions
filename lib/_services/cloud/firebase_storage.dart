import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/features/files/_helpers/download_web.dart';

import '../../_helpers/_common_helpers/permissions.dart';
import '../../_widgets/components/toast.dart';
import '../hive/local_storage_service.dart';
import 'handle_errors.dart';

CloudStorage cloudStorage = CloudStorage();

class CloudStorage {
  //
  // Storage Ref
  //
  final ref = FirebaseStorage.instance.ref();
  //
  //
  //
  // Upload Files
  //
  //
  //
  Future<void> uploadFile({required String path, required String fileId}) async {
    try {
      if (kIsWeb) {
        ref.child('tables/$path').putData(fileBox.get(fileId)).snapshotEvents.listen((taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              // TODO: Handle this case.
              print('....is uploading');
              break;
            case TaskState.paused:
              // TODO: Handle this case.
              print('....paused uploading');
              break;
            case TaskState.success:
              // TODO: Handle this case.
              print('....done uploading');
              break;
            case TaskState.canceled:
              // TODO: Handle this case.
              print('....canceled uploading');
              break;
            case TaskState.error:
              // TODO: Handle this case.
              print('....error uploading');
              break;
          }
        });
      } else {
        ref.child('tables/$path').putFile(File(fileBox.get(fileId))).snapshotEvents.listen((taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              // TODO: Handle this case.
              print('....is uploading');
              break;
            case TaskState.paused:
              // TODO: Handle this case.
              print('....paused uploading');
              break;
            case TaskState.success:
              // TODO: Handle this case.
              print('....done uploading');
              break;
            case TaskState.canceled:
              // TODO: Handle this case.
              print('....canceled uploading');
              break;
            case TaskState.error:
              // TODO: Handle this case.
              print('....error uploading');
              break;
          }
        });
      }
    } on FirebaseException catch (e) {
      showToast(0, handleFirebaseStorageError(e, process: 'upload file'));
    } catch (e) {
      errorPrint('upload-file-[$path]', e);
    }
  }

  //
  //
  //
  // Download Files
  //
  //
  //
  Future<void> downloadFile(String fileId, String cloudFilePath, String downloadPath) async {
    final fileRef = ref.child('tables/$cloudFilePath');

    print(fileRef.fullPath);

    try {
      if (kIsWeb) {
        //
        // If on Web
        //
        String fileUrl = await fileRef.getDownloadURL();
        downloadFileOnWeb(fileId, fileUrl);
      } else {
        //
        // is Android or IOS
        //
        String filePath = '/storage/emulated/0/Sessions/$downloadPath';

        await checkForStoragePermissions();

        final file = File(filePath);
        await file.create(recursive: true);

        final downloadTask = fileRef.writeToFile(file);
        downloadTask.snapshotEvents.listen((taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              // TODO: Handle this case.
              print('....is downloading');
              break;
            case TaskState.paused:
              // TODO: Handle this case.
              print('....paused downloading');
              break;
            case TaskState.success:
              // TODO: Handle this case.
              print('....done downloading');
              fileBox.put(fileId, filePath);
              break;
            case TaskState.canceled:
              // TODO: Handle this case.
              print('....canceled downloading');
              break;
            case TaskState.error:
              // TODO: Handle this case.
              print('....error downloading');
              break;
          }
        });
      }
    } on FirebaseException catch (e) {
      showToast(0, handleFirebaseStorageError(e, process: 'download file'));
    } catch (e) {
      errorPrint('donload-file', e);
    }
  }

  //
  //
  //
  // Delete Files
  //
  //
  //
  Future<void> deleteFile(String path) async {
    try {
      await ref.child('tables/$path').delete();
    } on FirebaseException catch (e) {
      showToast(0, handleFirebaseStorageError(e, process: 'delete file'));
    } catch (e) {
      errorPrint('delete-file', e);
    }
  }

  //
  //
  //
}
