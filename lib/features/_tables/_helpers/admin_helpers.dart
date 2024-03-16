import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/_common_helpers/internet_connection.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_services/cloud/checks.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/toast.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import 'get_table_data.dart';

Future<void> addAdminToTable(String email) async {
  try {
    if (email.isNotEmpty) {
      if (isValidEmail(email)) {
        hideKeyboard();

        hasAccessToInternet().then((value) async {
          if (value) {
            await doesUserExist(email).then((userData) async {
              if (userData.isNotEmpty) {
                String tableId = currentSelectedTable();
                String userId = userData.keys.first;

                await isAlreadyAdmin(tableId, userId).then((isAlreadyAdmin) async {
                  if (!isAlreadyAdmin) {
                    userEmailsBox.put(userId, userData[userId]['e']);
                    Hive.box('${tableId}_admins').put(userId, '0');

                    syncToCloud(tableId: tableId, where: 'admins', action: 'za', itemId: userId, isNew: true, data: {userId: '0'});

                    popWhatsOnTop();
                    showToast(1, 'Added new admin <b>$email</b>');
                  } else {
                    showToast(2, 'User is already admin');
                  }
                });
              } else {
                showToast(0, 'User does not exist');
              }
            });
          } else {}
        });
      } else {
        showToast(0, 'Enter a valid user email');
      }
    } else {
      showToast(0, 'Enter user email');
    }
  } catch (e) {
    showToast(0, 'Could not add admin');
  }
}

Future<void> removeAdminFromTable(BuildContext context, String userId, String userEmail) async {
  try {
    await showConfirmationDialog(title: 'Remove admin <b>$userEmail</b>?', yeslabel: 'Remove').then((removeYes) async {
      if (removeYes == true) {
        String tableId = currentSelectedTable();

        await isTableOwnerFirebase(tableId, userId).then((isOwner) async {
          if (!isOwner) {
            Hive.box('${tableId}_admins').delete(userId);

            syncToCloud(tableId: tableId, where: 'admins', action: 'zr', itemId: userId, isDelete: true, data: {});

            showToast(1, 'Removed admin <b>$userEmail</b>');
          } else {
            showToast(0, 'Table owner cannot be removed');
          }
        });
      }
    });
  } catch (e) {
    errorPrint('remove-admin', e);
    showToast(0, 'Could not remove admin');
  }
}

Future<void> getAdminEmail(String userId) async {
  try {
    String adminEmail = await getUserEmailFromCloud(userId);
    userEmailsBox.put(userId, adminEmail);
  } catch (e) {
    errorPrint('get-admin-email', e);
  }
}
