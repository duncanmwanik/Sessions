import 'package:flutter/material.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_helpers/notifications/create_notification.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_widgets/components/toast.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_tables/_helpers/get_table_data.dart';

void deleteSession(BuildContext context, {required String sessionDate, required String sessionId, required String sessionName}) async {
  try {
    await showConfirmationDialog(
      title: 'Delete <b>$sessionName</b> on <b>${getDayInfo(sessionDate)}</b>?',
      yeslabel: 'Delete',
    ).then((value) async {
      if (value == true) {
        // close dialog
        popWhatsOnTop();
        closeBottomSheetIfOpen();

        // TODO: cancel well reminders
        cancelScheduledNotification(sessionId);

        syncToCloud(tableId: currentSelectedTable(), where: 'sessions', action: 'sd', itemId: sessionId, isDelete: true, dates: [sessionDate], data: {});
      }
    });
  } catch (e) {
    showToast(0, 'Could not delete session');
    errorPrint('delete-session', e);
  }
}
